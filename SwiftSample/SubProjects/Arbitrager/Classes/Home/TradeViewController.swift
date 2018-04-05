//
//  TradeViewController.swift
//  Arbitrager
//
//  Created by Chris Song on 2018. 1. 14..
//  Copyright © 2018년 Chris Song. All rights reserved.
//

import UIKit

class TradeViewController: UIViewController {

    @IBOutlet weak var imgCoin: UIImageView!
    @IBOutlet weak var lbeCoinName: UILabel!
    @IBOutlet weak var txfCurrencyAmount: UITextField!
    @IBOutlet weak var txfUSDAmount: UITextField!
    
    var cryptoCurrencyType = CryptoCurrencyType.unkown
    
    static func storyboardInstance() -> TradeViewController {
        let storyboard = UIStoryboard.init(name: classNameToString(), bundle: nil)
        
        return storyboard.instantiateInitialViewController() as! TradeViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lbeCoinName.text = self.cryptoCurrencyType.rawValue
        self.txfCurrencyAmount.placeholder = self.cryptoCurrencyType.rawValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
