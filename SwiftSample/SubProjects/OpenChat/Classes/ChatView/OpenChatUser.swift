//
//  OpenChatUser.swift
//  SwiftSample
//
//  Created by Chris Song on 11/04/2018.
//  Copyright © 2018 ChrisMJSong. All rights reserved.
//

import UIKit

class OpenChatUser: NSObject {
    var id: String!
    var name: String!
    
    override convenience init() {
        self.init(id: "unknown", name: "anonymouse")
    }
    
    init(id:String, name: String) {
        self.id     = id
        self.name   = name
    }
}
