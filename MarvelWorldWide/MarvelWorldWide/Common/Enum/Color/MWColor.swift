//
//  MWColor.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import UIKit
/** Main class of the application colors, responsible for the dynamic creation of colors depending on the version of the device and the type of theme that is configured on the device (Dark Mode or Light Mode) ,
 - Important: Only the dynamism of colors works in iOS 13
 */
enum MWColor {
    
    /** Palette Color declaration
     - Important: Only declare all colors into this structure whit Hexadecimal Format
     */
    private struct MWColor {
        static let white = UIColor(hex: "#FAFAFAFF")
        static let gray = UIColor(hex: "#707070FF")
        static let black = UIColor(hex: "#2A2A2AFF")
    }
    
    /** Return different color depends to the UserInterfaceStyle (LightMode or DarkMode)
     - Important: Add here  the computed property for color declared in the Colors structure
     */
    static let white: UIColor = {
        if #available(iOS 13.0, *) {
            let color = UIColor { (trait) -> UIColor in
                return trait.userInterfaceStyle == .dark ? MWColor.black : MWColor.white
            }
            return color
        } else {
            return MWColor.white
        }
    }()
    
    static let black: UIColor = {
        if #available(iOS 13.0, *) {
            let color = UIColor { (trait) -> UIColor in
                return trait.userInterfaceStyle == .dark ? MWColor.white : MWColor.black
            }
            return color
        } else {
            return MWColor.black
        }
    }()
    
    static let gray: UIColor = {
        if #available(iOS 13.0, *) {
            let color = UIColor { (trait) -> UIColor in
                return trait.userInterfaceStyle == .dark ? MWColor.gray : MWColor.gray
            }
            return color
        } else {
            return MWColor.gray
        }
    }()
}
