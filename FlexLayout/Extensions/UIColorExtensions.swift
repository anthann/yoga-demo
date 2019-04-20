//
//  UIColorExtensions.swift
//  FlexLayout
//
//  Created by anthann on 2019/4/20.
//  Copyright © 2019 anthann. All rights reserved.
//

import UIKit

internal extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var uHexInt: UInt32 = 0
        let scanner = Scanner(string: hexString)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt32(&uHexInt)
        let hexInt = Int(uHexInt)
        self.init(hexInt: hexInt, alpha: alpha)
    }
    
    convenience init(hexInt: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hexInt & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexInt & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexInt & 0xff) >> 0) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static func random(alpha: CGFloat = 1.0) -> UIColor {
        let r = CGFloat(arc4random() % 256)
        let g = CGFloat(arc4random() % 256)
        let b = CGFloat(arc4random() % 256)
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
}
