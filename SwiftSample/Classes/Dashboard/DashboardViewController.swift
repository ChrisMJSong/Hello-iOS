//
//  DashboardViewController.swift
//  SwiftSample
//
//  Created by Chris Song on 05/04/2018.
//  Copyright © 2018 ChrisMJSong. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tableViewModel = DashboardTableViewModel()
    let reuseCellIdentifier = "DashboardCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK - UITableViewDataSource
extension DashboardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel.numberOfRowsInSection()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellIdentifier) as! DashboardTableViewCell
        return cell
    }
}