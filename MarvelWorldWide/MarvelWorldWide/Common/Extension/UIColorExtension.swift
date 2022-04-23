//
//  UIColorExtension.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import UIKit
/// Initializer that allows you to create a UIColor by passing a hexadecimal representation as String as a parameter
extension UIColor {
    public convenience init(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            } else {
                self.init(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1 / 255)
                return
            }
        }
        self.init(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1 / 255)
        return
    }
}
