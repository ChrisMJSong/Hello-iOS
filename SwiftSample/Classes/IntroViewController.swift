//
//  IntroViewController.swift
//  SwiftSample
//
//  Created by Chris Song on 04/04/2018.
//  Copyright © 2018 ChrisMJSong. All rights reserved.
//

import UIKit
import SwiftyGif
import YLProgressBar

class IntroViewController: UIViewController {

    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var viewProgress: YLProgressBar!
    let moveDeleay: Double = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // set gif image into logo imageview
        let gif = UIImage.init(gifName: "imgLion")
        imageViewLogo.setGifImage(gif)
        
        // Start fake animating
        viewProgress.type = .rounded
        viewProgress.progress = 0
        
        // ProgressTimer
        Timer.scheduledTimer(withTimeInterval: 1.0/10, repeats: true) { (timer) in
            let value: CGFloat = CGFloat((1.0/10) / self.moveDeleay);
            let targetProgress = self.viewProgress.progress + value
            
            self.viewProgress.progress = targetProgress
            
            if self.viewProgress.progress >= 1 {
                // destroy self
                timer.invalidate()
                // TODO: play complete animation
                // Go to dashboard after 0.5 sec
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.performSegue(withIdentifier: "SegueDashboard", sender: nil)
                })
            }
        }
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
