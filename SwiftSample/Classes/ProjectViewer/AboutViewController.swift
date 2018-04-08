//
//  AboutViewController.swift
//  SwiftSample
//
//  Created by Chris Song on 08/04/2018.
//  Copyright © 2018 ChrisMJSong. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var lbeDescription: UILabel!
    
    var descript: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lbeDescription.text = descript
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Dismiss view controller
    ///
    /// - Parameter sender: UIButton
    @IBAction func closeModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
