//
//  DashboardItem.swift
//  SwiftSample
//
//  Created by Chris Song on 05/04/2018.
//  Copyright © 2018 ChrisMJSong. All rights reserved.
//

import UIKit

class DashboardItem: NSObject {
    
    enum SkillTag: Int {
        case swift = 0, objc, json, tcpip, gis, realtimeDB, fcm
        
        /// Return a string that skill name
        ///
        /// - Returns: Tag string
        func Description() -> String {
            switch self {
            case .swift:    return "Swift"
            case .objc:     return "Objective-C"
            case .json:     return "JSON"
            case .tcpip:    return "TCP/IP"
            case .gis:      return "GIS"
            case .realtimeDB:      return "Real-Time DB"
            case .fcm:      return "FCM"
            }
        }
    }
    
    var name: String
    var tags: Array<SkillTag> = Array()
    var image: UIImage?
    var id: String
    var storyboardName: String!
    
    /// Default init
    override convenience init() {
        self.init(id: "", name: "", tags: Array<SkillTag>(), storyboardName: "", image: nil)
    }
    
    /// Init with item
    ///
    /// - Parameters:
    ///   - id: Dd string
    ///   - name: Name string
    ///   - image: Icon image (optional)
    init(id: String, name: String, tags: Array<SkillTag>, storyboardName: String, image: UIImage?) {
        self.id     = id
        self.name   = name
        self.tags   = tags
        self.image  = image
        self.storyboardName = storyboardName
    }
    
    /// Return a string that tag list
    ///
    /// - Returns: tag list
    func taglist() -> String {
        guard tags.count > 0 else { return "Unknown" }
        
        var result = ""
        for tag in tags {
            result.append(String.init(stringLiteral: "#\(tag.Description()), "))
        }
        let removeRange = result.index(result.endIndex, offsetBy: -2)..<result.endIndex
        result.removeSubrange(removeRange)
        
        return result
    }
}
