//
//  Extensions.swift
//  Arbitrager
//
//  Created by Chris Song on 2018. 1. 13..
//  Copyright © 2018년 Chris Song. All rights reserved.
//

import UIKit

extension NSObject {
    static func classNameToString() -> String {
        return String.init(describing: self)
    }
    
}

extension UIImage {
    
    /// 이미지뷰에 틴트 컬러를 적용함.
    ///
    /// - Parameter color: 적용할 틴트 컬러
    /// - Returns: 적용 후 이미지
    func maskWithColor(color: UIColor) -> UIImage?  {
        
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
        
    }
    
}
