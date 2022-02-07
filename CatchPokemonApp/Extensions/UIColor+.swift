//
//  UIColor+.swift
//  CatchPokemonApp
//
//  Created by Bening Ranum on 05/02/22.
//

import Foundation
import UIKit

struct AppColor {
    static let PRIMARY = UIColor(hex: "#22577AFF")
    static let SECONDARY = UIColor(hex: "#38A3A5FF")
    
    // MARK: - Stat Colors
    static let HP_COLOR = UIColor(hex: "#fe5a58ff")
    static let ATTACK_COLOR = UIColor(hex: "#f5ac79ff")
    static let DEFENSE_COLOR = UIColor(hex: "#fbe078ff")
    static let SPEED_COLOR = UIColor(hex: "#fa92b3ff")
    static let SPATK_COLOR = UIColor(hex: "#9db8f4ff")
    static let SPDEF_COLOR = UIColor(hex: "#a7dc8eff")
}

extension UIColor {
    public convenience init?(hex: String) {
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
            }
        }
        
        return nil
    }
}
