//
//  OpenChatMessage.swift
//  SwiftSample
//
//  Created by Chris Song on 11/04/2018.
//  Copyright © 2018 ChrisMJSong. All rights reserved.
//

import UIKit

class OpenChatMessage: NSObject {
    let user: OpenChatUser!
    let message: String!
    let time: Date!
    
    override convenience init() {
        self.init(user: OpenChatUser(), message: " ")
    }
    
    init(user: OpenChatUser, message: String) {
        self.user    = user
        self.message = message
        self.time    = Date()
    }
}
