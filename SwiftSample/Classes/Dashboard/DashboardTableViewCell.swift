//
//  DashboardTableViewCell.swift
//  SwiftSample
//
//  Created by Chris Song on 05/04/2018.
//  Copyright © 2018 ChrisMJSong. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var lbeSubject: UILabel!
    @IBOutlet weak var lbeTags: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageViewIcon.layer.cornerRadius = 5.0
        imageViewIcon.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// Update tableview cell
    ///
    /// - Parameter item: DashboardItem
    func updateItem(_ item: DashboardItem) {
        lbeSubject.text     = item.name
        lbeTags.text        = item.taglist()
        imageViewIcon.image = item.image
    }

}
