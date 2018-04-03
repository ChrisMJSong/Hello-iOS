//
//  IntroViewController.swift
//  SwiftSample
//
//  Created by Chris Song on 04/04/2018.
//  Copyright © 2018 ChrisMJSong. All rights reserved.
//

import UIKit
import SwiftyGif

class IntroViewController: UIViewController {

    @IBOutlet weak var imageViewLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // set gif image into logo imageview
        let gif = UIImage.init(gifName: "imgLion")
        imageViewLogo.setGifImage(gif)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
