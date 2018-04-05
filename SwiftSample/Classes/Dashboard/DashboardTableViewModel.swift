//
//  DashboardTableViewModel.swift
//  SwiftSample
//
//  Created by Chris Song on 05/04/2018.
//  Copyright © 2018 ChrisMJSong. All rights reserved.
//

import UIKit

class DashboardTableViewModel: NSObject {
    var items = Array<DashboardItem>()
    
    override init() {
        let item1 = DashboardItem.init(id: "com.ChrisMJSong.Arbitrager", name: "5만불가즈아", tags: [.swift, .json], image: #imageLiteral(resourceName: "IcoArbitrager"))
        items.append(item1)
    }
    
    /// Add item
    ///
    /// - Parameter item: item object
    func addItem(_ item: DashboardItem) {
        items.append(item)
    }
    
    /// Remove item at index
    ///
    /// - Parameter index: deleting item index
    func removeItemAtIndex(_ index: Int) {
        items.remove(at: index)
    }
    
    /// return number of rows to tableview
    ///
    /// - Returns: item count
    func numberOfRowsInSection() -> Int {
        return items.count
    }
    
    /// return number of section to tableview
    ///
    /// - Returns: section count
    func numberOfSection() -> Int {
        return 1
    }
}
