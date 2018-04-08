//
//  ProjectViewController.swift
//  SwiftSample
//
//  Created by Chris Song on 06/04/2018.
//  Copyright © 2018 ChrisMJSong. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController {

    @IBOutlet weak var viewProjectMain: UIView!
    @IBOutlet weak var viewBottomMenu: UIView!
    var initViewController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // FIXME: Only load default project
        
        let storyboard = UIStoryboard.init(name: "Arbitrager", bundle: nil)
        initViewController = storyboard.instantiateInitialViewController() as? UINavigationController
        var frame = self.view.frame
        frame.size.height -= self.viewBottomMenu.frame.height
        initViewController?.view.frame = frame
        self.view.addSubview((initViewController?.view)!)
        
        initViewController?.didMove(toParentViewController: self)
        
        self.view.bringSubview(toFront: self.viewBottomMenu)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "SegueAbout"?:
            do {
                let firstView = initViewController as? ProjectInitNavigationViewController
                let destView = segue.destination as! AboutViewController
                if let description = firstView?.projectDescription {
                    destView.descript = description()
                }
            }
        default: break
        }
    }
    
    /// Dismiss view controller
    ///
    /// - Parameter sender: UIButton
    @IBAction func closeModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// Show about a project
    ///
    /// - Parameter sender: UIButton
    @IBAction func about(_ sender: Any) {
    }
    
}
