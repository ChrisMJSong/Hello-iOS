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
