//
//  OpenChatTableViewModel.swift
//  SwiftSample
//
//  Created by Chris Song on 11/04/2018.
//  Copyright © 2018 ChrisMJSong. All rights reserved.
//

import UIKit

class OpenChatTableViewModel: NSObject {
    var room: OpenChatRoom!
    
    override init() {
        self.room = OpenChatRoom()
    }
    
    func message(at index: Int) -> OpenChatMessage {
        return room.message(at: index)
    }
    
    func addMessage(_ messageString: String) {
        // FIXME: addTestUser
        let testUser = OpenChatUser.init(id: "testid", name: "my name")
        let message = OpenChatMessage.init(user: testUser, message: messageString)
        room.addMessage(message)
    }
    
    /// return number of rows to tableview
    ///
    /// - Returns: item count
    func numberOfRowsInSection() -> Int {
        return room.messages.count
    }
    
    /// return number of section to tableview
    ///
    /// - Returns: section count
    func numberOfSection() -> Int {
        return 1
    }
}
