//
//  OpenChatMessageTableViewCell.swift
//  SwiftSample
//
//  Created by Chris Song on 06/05/2018.
//  Copyright © 2018 ChrisMJSong. All rights reserved.
//

import UIKit

class OpenChatMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var lbeChatMessage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateMessage(_ message: OpenChatMessage) {
        lbeChatMessage.text = message.message
    }
}
