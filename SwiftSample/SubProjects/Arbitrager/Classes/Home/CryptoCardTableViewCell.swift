//
//  CryptoCardTableViewCell.swift
//  Arbitrager
//
//  Created by Chris Song on 2018. 1. 13..
//  Copyright © 2018년 Chris Song. All rights reserved.
//

import UIKit

class CryptoCardTableViewCell: UITableViewCell {

    @IBOutlet weak var imgCoin: UIImageView!
    @IBOutlet weak var lbeCoinName: UILabel!
    @IBOutlet weak var lbeCoinNameShort: UILabel!
    @IBOutlet weak var lbePremiumValue: UILabel!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewBuy: CoinPriceView!
    @IBOutlet weak var viewSell: CoinPriceView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgCoin.image = imgCoin.image?.maskWithColor(color: UIColor.white)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateCard(_ data: CryptoCardData, _ krwValue: Float) {
        self.imgCoin.image          = data.imgCryptoCurrencySquare.maskWithColor(color: UIColor.white)
        self.lbeCoinName.text       = data.name
        self.lbeCoinNameShort.text  = data.nameShort
        self.viewHeader.backgroundColor = data.themeColor
        
        let srcLastPrice = data.srcExchange.lastPrice
        let dstLastPrice = data.dstExchange.lastPrice
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = 0
        let formedSrcLastPrice = numberFormatter.string(from: NSNumber(value:srcLastPrice))
        let formedDstLastPrice = numberFormatter.string(from: NSNumber(value:dstLastPrice))
        numberFormatter.maximumFractionDigits = 4
        let formedSrcLastUsdPrice = numberFormatter.string(from: NSNumber(value:srcLastPrice / krwValue))
        let formedDstLastUsdPrice = numberFormatter.string(from: NSNumber(value:dstLastPrice / krwValue))
        
        self.viewBuy.lbeLastPrice.text = formedSrcLastPrice! + " KRW"
        self.viewSell.lbeLastPrice.text = formedDstLastPrice! + " KRW"
        self.viewBuy.lbeLastUsdPrice.text = "(" + formedSrcLastUsdPrice! + " USD)"
        self.viewSell.lbeLastUsdPrice.text = "(" + formedDstLastUsdPrice! + " USD)"
        
        self.lbePremiumValue.text = String.init(format: "+%.1f%%", (Float(dstLastPrice) / Float(srcLastPrice) - 1) * 100)
    }
}

class CoinPriceView: UIView {
    @IBOutlet weak var imgExchangeLogo: UIImageView!
    @IBOutlet weak var lbeExchangeName: UILabel!
    @IBOutlet weak var lbeLastPrice: UILabel!
    @IBOutlet weak var lbeLastUsdPrice: UILabel!
}
