//
//  OpenChatRoom.swift
//  SwiftSample
//
//  Created by Chris Song on 11/04/2018.
//  Copyright © 2018 ChrisMJSong. All rights reserved.
//

import UIKit

class OpenChatRoom: NSObject {
    var messages: Array<OpenChatMessage> = Array()
    var users: Array<OpenChatUser> = Array()
    var title: String!
    
    override init() {
        self.title = "Chat Room"
    }
    
    func addMessage(_ message: OpenChatMessage) {
        messages.append(message)
    }
}
