//
//  Extensions.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 27/10/17.
//

import Foundation

extension UIView {
    @IBInspectable var viewCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    @IBInspectable var viewBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var viewBorderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return    UIColor(cgColor: color)
            } else {
                return nil
            }
        }
        set {
            if let color = newValue?.cgColor {
                layer.borderColor = color
            }
        }
    }
}

extension UIColor {
    /**
     Returns UIColor from hex color string of type #RRGGBB or #AARRGGBB
     */
    convenience init(hexString: String) {
        let hexString2 = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString2)

        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }

        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask: UInt32 = 0x000000FF
        let r = (color >> 16) & mask
        let g = (color >> 8) & mask
        let b = (color) & mask

        var a: UInt32 = 255
        if hexString.characters.count > 7 {
            a = (color >> 24) & mask
        }

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        let alpha = CGFloat(a) / 255.0

        self.init(red:red, green:green, blue:blue, alpha: alpha)
    }
}
