//
//  Colors.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 28/10/17.
//

import Foundation
import SwiftyJSON

extension StyleGuide {
    public class Colors {

        private var colors: [String: UIColor]

        init(fromJSON json: JSON) {
            var colors: [String: UIColor] = [:]
            json.dictionary?.forEach({ (colorName: String, colorValue: JSON) in
                if let colorString = colorValue.string?.trimmingCharacters(in: .whitespaces) {
                    colors[colorName] = UIColor(hex: colorString)
                }
            })
            self.colors = colors
        }

        subscript(colorName: String?) -> UIColor? {

            guard let colorName = colorName else {
                return nil
            }

            //if the color is named, return the stored value otherwise parse hex value of color
            if let varName = Utils.parseVariableName(fromString: colorName) {
                return self.colors[varName]
            } else {
                return UIColor(hex: colorName)
            }
        }
    }
}

private extension UIColor {
    convenience init(hex hexString: String) {
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
