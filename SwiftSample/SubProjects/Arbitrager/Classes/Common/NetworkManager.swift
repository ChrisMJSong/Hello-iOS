//
//  NetworkManager.swift
//  Arbitrager
//
//  Created by Chris Song on 2017. 6. 21..
//  Copyright © 2017년 Chris Song. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

let kCexServerUrl = "https://cex.io/api"
let kCoinOneServerUrl = "https://api.coinone.co.kr"

enum ExchangeType: String {
    case cex = "CEX", coinone = "Coinone"
}

enum ConnectionErrorType: String{
    case unknown = "알 수 없는 오류가 발생했습니다.",
    connectionError = "서버에 연결할 수 없습니다.",
    noData = "데이터가 없습니다."
}

class MultiPartData {
    var data: Data
    var name: String
    var path: URL?
    
    init(_ data:Data, _ name:String){
        self.data = data
        self.name = name
    }
}

public typealias CompletionHandler = (_ result: JSON) -> Void

final class NetworkManager: NSObject {
    static let shared = NetworkManager()
    var sessionManager: Alamofire.SessionManager? = nil
    
    private override init(){
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest  = 60
        configuration.timeoutIntervalForResource = 60
        
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func getPushToken() -> String{
        return "testTokenString"
    }
    
    // MARK: - Utility Function
    func dummyResult(_ errorString: String) -> JSON{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        
        let object: [String : Any] = [
            "header": [
                "message": errorString,
                "responseTime": dateFormatter.string(from: Date()),
                "code": "9999"
            ],
            "body": [
                "Description": "This is dummy data for error."
            ],
            ]
        let json = JSON.init(object)
        return json
    }
    
    func dummyResult(_ errorType: ConnectionErrorType) -> JSON{
        return self.dummyResult(errorType.rawValue)
    }
    
    
    /// JSON결과의 오류 여부를 확인
    ///
    /// - Parameter json: JSON 결과값
    /// - Returns: 정상 여부, 처리 결과 메시지
    func isSuccess(_ json: JSON) -> (Bool, String){
        let resultCode = json["header"]["code"].intValue
        let resultMsg  = json["header"]["message"].stringValue
        
        return (resultCode == 0, resultMsg)
    }
    
    
    func imagesToMultiParts(_ images:Array<UIImage>) -> Array<MultiPartData> {
        // make time stamp
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let dateString = dateFormatter.string(from: Date())
        
        var multiParts = Array<MultiPartData>()
        for i in 0..<images.count {
            let image = images[i]
            let tempData = MultiPartData(UIImagePNGRepresentation(image)!, dateString.appendingFormat("%d.png", i))
            multiParts.append(tempData)
        }
        return multiParts
    }
    
    // MARK: - Common Function
    func performRequest(_ url: String, _ completion: @escaping CompletionHandler) {
        
        SVProgressHUD.show()
        
        if let urlString = url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) {
            let utilityQueue = DispatchQueue.global(qos: .utility)
            
            sessionManager?.request(urlString).responseJSON(queue: utilityQueue) {response in
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    // Validation
                    
                    guard response.result.isSuccess else {
                        // Connection Error
                        let result = self.dummyResult((response.result.error?.localizedDescription)!)
                        completion(result)
                        return
                    }
                    
                    guard let jsonData = response.data else {
                        // No data
                        let result = self.dummyResult(.noData)
                        completion(result)
                        return
                    }
                    do {
                        let json = try JSON(data: jsonData)
                        completion(json)
                    }catch {
                    }
                }
            }
        }
    }
    
    func performRequest(_ url: String, _ parameters: Parameters? = nil, _ completion: @escaping CompletionHandler){
        SVProgressHUD.show()
        
        if let urlString = url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) {
            #if DEBUG
                var params = ""
                if let realParams = parameters {
                    params = "?"
                    for value in realParams {
                        let key = value.key
                        let value = value.value as? String ?? String.init(value.value as! Int)
                        params.append(key + "=" + value + "&")
                    }
                    params.removeLast()
                }
                print("** Request URL **")
                print(urlString + params)
            #endif
          
            let utilityQueue = DispatchQueue.global(qos: .utility)
            
            sessionManager?.request(urlString, method: HTTPMethod.post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(queue: utilityQueue) {response in
                
                DispatchQueue.main.async {
                    
                    SVProgressHUD.dismiss()
                    // Validation
                    
                    guard response.result.isSuccess else {
                        // Connection Error
                        let result = self.dummyResult((response.result.error?.localizedDescription)!)
                        completion(result)
                        return
                    }
                    
                    guard let jsonData = response.data else {
                        // No data
                        let result = self.dummyResult(.noData)
                        completion(result)
                        return
                    }
                    do {
                        
                        let json = try JSON(data: jsonData)
                        
                        #if DEBUG
                            print("** Request Result **")
                            print(json)
                        #endif
                        completion(json)
                    }catch {
                    }
                }
            }
        }
    }
    
    func performMultipartRequest(_ url: String, parameters: Parameters? = nil, multiParts: Array<MultiPartData>? = nil, _ completion: @escaping CompletionHandler){
        
        SVProgressHUD.show()
        #if DEBUG
            print("Request URL:", url)
        #endif
        
        // Create temporary
        let path = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("temp")
        do{
            try FileManager.default.createDirectory(atPath: path.path, withIntermediateDirectories: true, attributes: nil)
        }catch{
        }
        
        if multiParts != nil{
            for item in multiParts!{
                do {
                    let savedPath = path.appendingPathComponent(item.name)
                    try item.data.write(to: savedPath)
                    item.path = savedPath
                }catch{
                    print(error)
                }
            }
        }
        
        sessionManager?.upload(multipartFormData: { (multiPartFormData) in
            if multiParts != nil{
                for item in multiParts!{
                    multiPartFormData.append(item.path!, withName: item.name)
                }
            }
            
            if parameters != nil {
                for param in parameters! {
                    multiPartFormData.append(String(describing: param.value).data(using: .utf8)!, withName: param.key)
                }
            }
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: url, method: .post, headers: nil, encodingCompletion: { (encodingResult) in
            
            do{
                try FileManager.default.removeItem(atPath: URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("temp").path)
            }catch{
                print(error)
            }
            
            DispatchQueue.main.async{
                
                // Validation
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        
                        SVProgressHUD.dismiss()
                        
                        guard response.result.isSuccess else {
                            // Connection Error
                            let result = self.dummyResult((response.result.error?.localizedDescription)!)
                            completion(result)
                            return
                        }
                        
                        guard let jsonData = response.data else {
                            // No data
                            let result = self.dummyResult(.noData)
                            completion(result)
                            return
                        }
                        do {
                    
                        let json = try JSON(data: jsonData)
                        completion(json)
                        }catch {
                        }
                    }
                case .failure(let encodingError):
                    // Upload error
                    SVProgressHUD.dismiss()
                    let result = self.dummyResult(encodingError.localizedDescription)
                    completion(result)
                }
            }
        })
        
    }

    // MARK: - Server API
    
    /// CEX 코인 가격을 얻어온다.
    ///
    /// - Parameters:
    func getLastPrice(exchange: ExchangeType, completion: @escaping CompletionHandler) {
        var serverUrl = ""
        var api = ""
        switch exchange {
        case .cex:
            serverUrl = kCexServerUrl
            api = "/last_prices/USD"
        case .coinone:
            serverUrl = kCoinOneServerUrl
            api = "/ticker?currency=all"
            
        }
         self.performRequest(serverUrl.appending(api), completion)
    }
    
    /// 금일 환율을 얻어온다.
    ///
    /// - Parameter completion: 클로저 객체
    func todayExchangeRate(completion: @escaping CompletionHandler) {
        let serverUrl = "https://api.manana.kr/exchange/rate/KRW/USD,KRW.json"
        self.performRequest(serverUrl, completion)
    }
}
