//
//  HomeViewController.swift
//  Arbitrager
//
//  Created by Chris Song on 2018. 1. 13..
//  Copyright © 2018년 Chris Song. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbeUpdateDate: UILabel!
    @IBOutlet weak var lbeExchangeRate: UILabel!
    @IBOutlet weak var viewBarTimer: UIView!
    @IBOutlet var constraintViewBarTimerTrailing: NSLayoutConstraint!
    
    let updateDelay = 10.0
    var krwValue: Float = 1000.0
    var willUpdate = false
    var skipTimer = false
    let availableCoins: Array<CryptoCurrencyType> = [.btc, .bch, .eth, .xrp]
    var receivedItems: Array<ExchangeType> = []
    var tableData = Array<CryptoCardData>()
    var cexItems = Dictionary<String, Float>()
    var coinoneItems = Dictionary<String, Float>()
    var lastUpdatedDate = Date()
    var timerAutoRefresh: Timer?
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshEvent(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for item in self.availableCoins {
            let item = CryptoCardData(item)
            self.tableData.append(item)
        }
        
        self.runTimer()
    }
    
    func runTimer() {
        self.timerAutoRefresh = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (timer) in
            
            guard self.skipTimer == false else {return}
            
            var timeInterval = Date().timeIntervalSince(self.lastUpdatedDate)
            if timeInterval > self.updateDelay && self.willUpdate == false {
                self.refreshData("")
                timeInterval -= self.updateDelay
                self.willUpdate = true
            }
            
            let trailWidth = timeInterval / self.updateDelay * Double(UIScreen.main.bounds.size.width)
            self.constraintViewBarTimerTrailing.constant = CGFloat(trailWidth)
            
            self.view.setNeedsDisplay()
        }
    }
    
    func stopTimer() {
        timerAutoRefresh?.invalidate()
        self.constraintViewBarTimerTrailing.constant = 0
        self.view.setNeedsDisplay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.todayExchangeRate()
        self.refreshData("")
        skipTimer = false
    }

    override func viewDidDisappear(_ animated: Bool) {
        skipTimer = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 오늘의 환율을 얻어온다.
    func todayExchangeRate() {
        NetworkManager.shared.todayExchangeRate { (json) in
            if let array = json.array {
                self.krwValue = ((array[1].dictionaryValue)["rate"]?.float)!
            }
            self.lbeExchangeRate.text = "1 USD\n" + "\(self.krwValue) KRW\n" + "0.0000 BTC";
        }
    }
    
    /// 거래소 서버로부터 값을 갱신한다.
    @IBAction func refreshData(_ sender: Any) {
        self.lastUpdatedDate = Date()
        NetworkManager.shared.getLastPrice(exchange: .cex) { (json) in
            // CEX
            let values = json["data"].arrayValue
            for value in values {
                let currency = value["symbol1"].stringValue
                let price = value["lprice"].floatValue
                
                self.cexItems.updateValue(price * self.krwValue, forKey: currency)
            }
            
            self.didReceiveExchangeData(.cex)
        }
        
        NetworkManager.shared.getLastPrice(exchange: .coinone) { (json) in
            // Coinone
            for item in self.availableCoins {
                let itemKey = item.rawValue.lowercased()
                
                let xrp = json[itemKey]
                let lastPrice = xrp["last"].floatValue;
                
                self.coinoneItems.updateValue(lastPrice, forKey: itemKey.uppercased())
            }
            
            self.didReceiveExchangeData(.coinone)
        }
    }
    
    func didReceiveExchangeData(_ exchangeType: ExchangeType) {
        
        for cardData in self.tableData {
            let coinKey = cardData.nameShort
            
            if exchangeType == .cex {
                let cexItem = self.cexItems[coinKey]
                cardData.srcExchange.name = ExchangeType.cex.rawValue
                cardData.srcExchange.lastPrice = cexItem!
            }
            if exchangeType == .coinone {
                let coinoneItem = self.coinoneItems[coinKey]
                cardData.dstExchange.name = ExchangeType.coinone.rawValue
                cardData.dstExchange.lastPrice = coinoneItem!
            }
        }
        
        // 테이블을 갱신함
        self.receivedItems.removeAll()
        
        // 업데이트 시간을 갱신함.
        self.willUpdate = false
        let dateformatter = DateFormatter.init()
        dateformatter.dateFormat = "yyyy.MM.dd hh:MM:ss a"
        self.lbeUpdateDate.text = "Last Update: \n" + dateformatter.string(from: self.lastUpdatedDate)
        
        // UI쓰레드에서
        self.tableView.reloadData()
    }
    
    @objc func tableReload() {
        self.tableView.reloadData()
    }
    
    @IBAction func tableEdit(_ sender: Any) {
        self.tableView.setEditing(!self.tableView.isEditing, animated: true)
        
        let barButton = sender as! UIBarButtonItem
        if self.tableView.isEditing {
            stopTimer()
            barButton.title = "Done"
            barButton.style = .done
        }else{
            runTimer()
            barButton.title = "Edit"
            barButton.style = .plain
        }
    }
    
    @objc func refreshEvent(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
    }

    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell")
        
        return cell!.bounds.size.height;
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CryptoCardTableViewCell
        
        let data = self.tableData[indexPath.row]
        cell.updateCard(data, self.krwValue)
        
     return cell
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let data = self.tableData[indexPath.row]
//
//        let tradeView = TradeViewController.storyboardInstance()
//        tradeView.cryptoCurrencyType = data.type
//
//        self.navigationController?.pushViewController(tradeView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = self.tableData.remove(at: sourceIndexPath.row)
        self.tableData.insert(temp, at: destinationIndexPath.row)
        
    }
}

