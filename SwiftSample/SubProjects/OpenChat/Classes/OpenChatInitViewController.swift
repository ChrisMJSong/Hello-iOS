//
//  OpenChatInitViewController.swift
//  SwiftSample
//
//  Created by Chris Song on 10/04/2018.
//  Copyright © 2018 ChrisMJSong. All rights reserved.
//

import UIKit

class OpenChatInitViewController: ProjectInitNavigationViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Return a string that viewcontroller description
    ///
    /// - Returns: description string
    override func projectDescription() -> String {
        return NSLocalizedString("This project is a sample project of open chat. You can chat based on anonymous and chat message will be maintained.", comment: "Project description.")
    }

}
