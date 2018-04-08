//
//  ProjectInitNavigationViewController.swift
//  SwiftSample
//
//  Created by Chris Song on 08/04/2018.
//  Copyright © 2018 ChrisMJSong. All rights reserved.
//

import UIKit

class ProjectInitNavigationViewController: UINavigationController {

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
    func projectDescription() -> String {
        // it will be override
        return ""
    }

}
