//
//  DashboardItem.swift
//  SwiftSample
//
//  Created by Chris Song on 05/04/2018.
//  Copyright © 2018 ChrisMJSong. All rights reserved.
//

import UIKit

class DashboardItem: NSObject {
    var name: String
    var image: UIImage?
    var id: String
    
    /// Default init
    override convenience init() {
        self.init(id: "", name: "", image: nil)
    }
    
    /// Init with item
    ///
    /// - Parameters:
    ///   - id: Dd string
    ///   - name: Name string
    ///   - image: Icon image (optional)
    init(id: String, name: String, image: UIImage?) {
        self.id     = id
        self.name   = name
        self.image  = image
    }
}
