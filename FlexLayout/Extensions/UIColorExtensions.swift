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

internal extension UIColor {
    
    //MARK: -Brand
    class func brand100() -> UIColor {
        return UIColor(hexInt: 0x07C160)
    }
    
    class func brand170() -> UIColor {
        return UIColor(hexInt: 0xB4ECCE)
    }
    
    class func brand120() -> UIColor {
        return UIColor(hexInt: 0x38CD7F)
    }
    
    class func brand90() -> UIColor {
        return UIColor(hexInt: 0x06AE56)
    }
    
    class func brand80() -> UIColor {
        return UIColor(hexInt: 0x059A4C)
    }
    
    class func brandBG130() -> UIColor {
        return UIColor(hexInt: 0x69C694)
    }
    
    class func brandBG110() -> UIColor {
        return UIColor(hexInt: 0x3EB575)
    }
    
    class func brandBG100() -> UIColor {
        return UIColor(hexInt: 0x2AAE67)
    }
    
    class func brandBG90() -> UIColor {
        return UIColor(hexInt: 0x259C5C)
    }
    
    //MARK: -Purple
    class func purple100() -> UIColor {
        return UIColor(hexInt: 0x6467F0)
    }
    
    class func purple170() -> UIColor {
        return UIColor(hexInt: 0xD0D1FA)
    }
    
    class func purple120() -> UIColor {
        return UIColor(hexInt: 0x8385F3)
    }
    
    class func purple90() -> UIColor {
        return UIColor(hexInt: 0x595CD7)
    }
    
    class func purple80() -> UIColor {
        return UIColor(hexInt: 0x5052C0)
    }
    
    class func purpleBG130() -> UIColor {
        return UIColor(hexInt: 0x9496CE)
    }
    
    class func purpleBG110() -> UIColor {
        return UIColor(hexInt: 0x7678C1)
    }
    
    class func purpleBG100() -> UIColor {
        return UIColor(hexInt: 0x6769BA)
    }
    
    class func purpleBG90() -> UIColor {
        return UIColor(hexInt: 0x5C5EA7)
    }
    
    //MARK: -Indigo
    class func indigo100() -> UIColor {
        return UIColor(hexInt: 0x1485EE)
    }
    
    class func indigo170() -> UIColor {
        return UIColor(hexInt: 0xB8DAF9)
    }
    
    class func indigo120() -> UIColor {
        return UIColor(hexInt: 0x439DF1)
    }
    
    class func indigo90() -> UIColor {
        return UIColor(hexInt: 0x1277D6)
    }
    
    class func indigo80() -> UIColor {
        return UIColor(hexInt: 0x106ABE)
    }
    
    class func indigoBG130() -> UIColor {
        return UIColor(hexInt: 0x6BA0D2)
    }
    
    class func indigoBG110() -> UIColor {
        return UIColor(hexInt: 0x3F84C5)
    }
    
    class func indigoBG100() -> UIColor {
        return UIColor(hexInt: 0x2B77BF)
    }
    
    class func indigoBG90() -> UIColor {
        return UIColor(hexInt: 0x266AAB)
    }
    
    //MARK: -Blue
    class func blue100() -> UIColor {
        return UIColor(hexInt: 0x10aeff)
    }
    
    class func blue170() -> UIColor {
        return UIColor(hexInt: 0xB7E6FF)
    }
    
    class func blue110() -> UIColor {
        return UIColor(hexInt: 0x3FBEFF)
    }
    
    class func blue90() -> UIColor {
        return UIColor(hexInt: 0x0E9CE6)
    }
    
    class func blue80() -> UIColor {
        return UIColor(hexInt: 0x0C8BCC)
    }
    
    class func blueBG130() -> UIColor {
        return UIColor(hexInt: 0x7FC0EA)
    }
    
    class func blueBG110() -> UIColor {
        return UIColor(hexInt: 0x5AAFE4)
    }
    
    class func blueBG100() -> UIColor {
        return UIColor(hexInt: 0x48A6E2)
    }
    
    class func blueBG90() -> UIColor {
        return UIColor(hexInt: 0x4095CB)
    }
    
    //MARK: -Link
    class func link100() -> UIColor {
        return UIColor(hexInt: 0x576B95)
    }
    
    class func link170() -> UIColor {
        return UIColor(hexInt: 0xCCD2DE)
    }
    
    class func link120() -> UIColor {
        return UIColor(hexInt: 0x7888AA)
    }
    
    class func link90() -> UIColor {
        return UIColor(hexInt: 0x4E6083)
    }
    
    class func link80() -> UIColor {
        return UIColor(hexInt: 0x455577)
    }
    
    //MARK: -Red
    class func red100() -> UIColor {
        return UIColor(hexInt: 0xfa5151)
    }
    
    class func red170() -> UIColor {
        return UIColor(hexInt: 0xfdcaca)
    }
    
    class func red120() -> UIColor {
        return UIColor(hexInt: 0xfb7373)
    }
    
    class func red90() -> UIColor {
        return UIColor(hexInt: 0xe14949)
    }
    class func red80() -> UIColor {
        return UIColor(hexInt: 0xc84040)
    }
    
    class func redBG130() -> UIColor {
        return UIColor(hexInt: 0xdd847E)
    }
    
    class func redBG110() -> UIColor {
        return UIColor(hexInt: 0xD3625A)
    }
    
    class func reBG100() -> UIColor {
        return UIColor(hexInt: 0xCF5148)
    }
    
    class func reBG90() -> UIColor {
        return UIColor(hexInt: 0xB94840)
    }
    
    //MARK: -Orange
    class func orange100() -> UIColor {
        return UIColor(hexInt: 0xfa9d3b)
    }
    
    class func orange170() -> UIColor {
        return UIColor(hexInt: 0xFDE1C3)
    }
    
    class func orange120() -> UIColor {
        return UIColor(hexInt: 0xFBB062)
    }
    
    class func orange90() -> UIColor {
        return UIColor(hexInt: 0xE08C34)
    }
    
    class func orange80() -> UIColor {
        return UIColor(hexInt: 0xC87D2F)
    }
    
    class func orangeBG130() -> UIColor {
        return UIColor(hexInt: 0xF0A04D)
    }
    
    class func orangeBG110() -> UIColor {
        return UIColor(hexInt: 0xEc8519)
    }
    
    class func orangeBG100() -> UIColor {
        return UIColor(hexInt: 0xEA7800)
    }
    
    class func orangeBG90() -> UIColor {
        return UIColor(hexInt: 0xD26B00)
    }
    
    //MARK: -Yellow
    class func yellow100() -> UIColor {
        return UIColor(hexInt: 0xffc300)
    }
    
    class func yellow170() -> UIColor {
        return UIColor(hexInt: 0xFFECB2)
    }
    
    class func yellow120() -> UIColor {
        return UIColor(hexInt: 0xFFCF33)
    }
    
    class func yellow90() -> UIColor {
        return UIColor(hexInt: 0xE6AF00)
    }
    
    class func yellow80() -> UIColor {
        return UIColor(hexInt: 0xCC9C00)
    }
    
    class func yellowBG130() -> UIColor {
        return UIColor(hexInt: 0xF3CC4D)
    }
    
    class func yellowBG110() -> UIColor {
        return UIColor(hexInt: 0xF0BD19)
    }
    
    class func yellowBG100() -> UIColor {
        return UIColor(hexInt: 0xEFB600)
    }
    
    class func yellowBG90() -> UIColor {
        return UIColor(hexInt: 0xD7A400)
    }
    
    //MAKR: -Green
    class func green100() -> UIColor {
        return UIColor(hexInt: 0x91d300)
    }
    
    class func green170() -> UIColor {
        return UIColor(hexInt: 0xDEF1B3)
    }
    
    class func green120() -> UIColor {
        return UIColor(hexInt: 0xA7DB33)
    }
    
    class func green90() -> UIColor {
        return UIColor(hexInt: 0x82BD00)
    }
    
    class func green80() -> UIColor {
        return UIColor(hexInt: 0x74A800)
    }
    
    class func greenBG130() -> UIColor {
        return UIColor(hexInt: 0xB5D179)
    }
    
    class func greenBG110() -> UIColor {
        return UIColor(hexInt: 0xA0C452)
    }
    
    class func greenBG100() -> UIColor {
        return UIColor(hexInt: 0x96BE40)
    }
    
    class func greenBG90() -> UIColor {
        return UIColor(hexInt: 0x86AA39)
    }
    
    //MARK: LightGreen
    class func lightGreen100() -> UIColor {
        return UIColor(hexInt: 0x95ec69)
    }
    
    class func lightGreen170() -> UIColor {
        return UIColor(hexInt: 0xDEF9D1)
    }
    
    class func lightGreen120() -> UIColor {
        return UIColor(hexInt: 0xAAEF87)
    }
    
    class func lightGreen90() -> UIColor {
        return UIColor(hexInt: 0x85D35E)
    }
    
    class func lightGreen80() -> UIColor {
        return UIColor(hexInt: 0x77BC54)
    }
    
    class func lightGreenBG130() -> UIColor {
        return UIColor(hexInt: 0x9CDD90)
    }
    
    class func lightGreenBG110() -> UIColor {
        return UIColor(hexInt: 0x80D370)
    }
    
    class func lightGreenBG100() -> UIColor {
        return UIColor(hexInt: 0x72CF60)
    }
    
    class func lightGreenBG90() -> UIColor {
        return UIColor(hexInt: 0x66B956)
    }
    
}
