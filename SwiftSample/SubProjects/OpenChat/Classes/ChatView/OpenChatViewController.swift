//
//  OpenChatViewController.swift
//  SwiftSample
//
//  Created by Chris Song on 09/04/2018.
//  Copyright © 2018 ChrisMJSong. All rights reserved.
//

import UIKit

class OpenChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txvChatBox: UITextView!
    @IBOutlet weak var constantChatBoxHeight: NSLayoutConstraint!
    
    let tableViewModel = OpenChatTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = tableViewModel.room.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addItem(_ sender: Any) {
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        
        // reset
        txvChatBox.text = nil
    }
}

// MARK - UITableViewDataSource
extension OpenChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel.numberOfRowsInSection()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "")
        return cell!
    }
}

// MARK: UITextViewDelegate
extension OpenChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print("chagned!")
    }
}
