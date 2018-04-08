//
//  ArbitragerInitViewController.swift
//  SwiftSample
//
//  Created by Chris Song on 08/04/2018.
//  Copyright © 2018 ChrisMJSong. All rights reserved.
//

import UIKit

class ArbitragerInitViewController: ProjectInitNavigationViewController {

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
        return NSLocalizedString("This project is a project using the public API of Coin Exchange. The price between the two exchanges in real time and compare the profits.\nHowever, during the project, \"Kimchi Premium\" is broken and project is droped.", comment: "Project description.")
    }

}
