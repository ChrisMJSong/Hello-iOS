//
//  UserDataManager.swift
//  Arbitrager
//
//  Created by Chris Song on 2017. 12. 2..
//  Copyright © 2017년 Chris Song. All rights reserved.
//

import UIKit


enum CryptoCurrencyType: String {
    case unkown = "UNKNOWN", btc = "BTC", bch = "BCH", eth = "ETH", etc = "ETC", xrp = "XRP" , qtum = "QTUM", ltc = "LTC", iota = "IOTA", btg = "BTG"
}

class Coin: NSObject {
    var type = CryptoCurrencyType.unkown
}

class UserDataManager: NSObject {
    static let shared = UserDataManager()
    
    /// 임의의 문자열 생성
    ///
    /// - Parameter length: 문자열 길이
    /// - Returns: 임의의 문자열
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
}


class ExchangeData: NSObject {
    var name = ""
    var lastPrice: Float = 0.0
}

class CryptoCardData: NSObject {
    var name: String {
        var shortName = ""
        switch self.type {
        case .unkown:
            shortName = "Unknown"
        case .btc:
            shortName = "Bitcoin"
        case .bch:
            shortName = "Bitcoin Cash"
        case .eth:
            shortName = "Ethereum"
        case .etc:
            shortName = "Ethereum Classic"
        case .xrp:
            shortName = "Ripple"
        case .qtum:
            shortName = "Qtum"
        case .ltc:
            shortName = "Litecoin"
        case .iota:
            shortName = "IOTA"
        case .btg:
            shortName = "Bitcoin Gold"
        }
        
        return shortName
    }
    var nameShort: String {
        return self.type.rawValue
    }
    var imgCryptoCurrencySquare: UIImage {
        var image: UIImage = #imageLiteral(resourceName: "icoBitcoin_sq")
        switch self.type {
        case .unkown:
            image = #imageLiteral(resourceName: "icoBitcoin_sq")
        case .btc:
            image = #imageLiteral(resourceName: "icoBitcoin_sq")
        case .bch:
            image = #imageLiteral(resourceName: "icoBitcoin_sq")
        case .eth:
            image = #imageLiteral(resourceName: "icoEthereum_sq")
        case .etc:
            image = #imageLiteral(resourceName: "icoEthereum_sq")
        case .xrp:
            image = #imageLiteral(resourceName: "icoRipple_sq")
        case .qtum:
            image = #imageLiteral(resourceName: "icoBitcoin_sq")
        case .ltc:
            image = #imageLiteral(resourceName: "icoLitecoin_sq")
        case .iota:
            image = #imageLiteral(resourceName: "icoIOTA_sq")
        case .btg:
            image = #imageLiteral(resourceName: "icoBitcoin_sq")
        }
        
        return image
    }
    var themeColor: UIColor {
        var color: UIColor = UIColor(red:0.95, green:0.48, blue:0.04, alpha:1.00)
        switch self.type {
        case .unkown:
            color = UIColor.lightGray
        case .btc:
            color = UIColor(red:0.95, green:0.48, blue:0.04, alpha:1.00)
        case .bch:
            color = UIColor(red:0.24, green:0.49, blue:0.38, alpha:1.00)
        case .eth:
            color = UIColor(red:0.38, green:0.42, blue:0.68, alpha:1.00)
        case .etc:
            color = UIColor(red:0.00, green:0.56, blue:0.56, alpha:1.00)
        case .xrp:
            color = UIColor(red:0.03, green:0.38, blue:0.55, alpha:1.00)
        case .qtum:
            color = UIColor(red:0.16, green:0.56, blue:0.79, alpha:1.00)
        case .ltc:
            color = UIColor(red:0.31, green:0.37, blue:0.44, alpha:1.00)
        case .iota:
            color = UIColor(red:0.33, green:0.28, blue:0.66, alpha:1.00)
        case .btg:
            color = UIColor(red:0.79, green:0.57, blue:0.18, alpha:1.00)
        }
        
        return color
    }
    var primeumValue: Float {
        return (self.dstExchange.lastPrice / self.srcExchange.lastPrice - 1) * 100
    }
    var type = CryptoCurrencyType.unkown
    var srcExchange = ExchangeData()
    var dstExchange = ExchangeData()
    
    init(_ type: CryptoCurrencyType) {
        self.type = type
    }
    
    
}
