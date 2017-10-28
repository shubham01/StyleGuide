//
//  Utils.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 28/10/17.
//

import Foundation
import SwiftyJSON

class Utils {
    class func parseVariableName(fromString string: String) -> String? {
        let string = string.trimmingCharacters(in: .whitespaces)
        if string.first == "@" {
            let fromIndex = string.index(string.startIndex, offsetBy: 1)
            return string.substring(from: fromIndex)
        }
        return nil
    }

    /**
     Parse font from string to UIFont object
     - parameter from: The input font string in format -> "size,fontName"
     - returns: UIFont object if successful, nil otherwise. If font name is not specified, system font of asked size is returned.
     */
    class func parseFont(from string: String?) -> UIFont? {

        guard let values = string?.components(separatedBy: ","), values.count > 0 else {
            return nil
        }

        var properties: [String: String] = [:]
        for value in values {
            let components = value.components(separatedBy: ":")
            if components.count == 2 {
                properties[components[0].trimmingCharacters(in: .whitespaces)] = components[1].trimmingCharacters(in: .whitespaces)
            }
        }

        guard let fontSize = cgFloatFrom(string: properties["size"]) else {
            return nil
        }
        let fontWeight = fontWeightFrom(string: properties["weight"])

        if let family = properties["family"] {
            let traits = [UIFontDescriptor.TraitKey.weight: fontWeight]
            let fontDescriptor = UIFontDescriptor(fontAttributes: [UIFontDescriptor.AttributeName.family: family,
                                                                   UIFontDescriptor.AttributeName.traits: traits])
            return UIFont(descriptor: fontDescriptor, size: fontSize)
        } else {
            return UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        }
    }

    class func cgFloatFrom(string: String?) -> CGFloat? {
        guard let string = string else {
            return nil
        }
        if let number = NumberFormatter().number(from: string) {
            return CGFloat(number)
        }
        return nil
    }

    class func fontWeightFrom(string: String?) -> UIFont.Weight {

        guard let string = string else {
            return UIFont.Weight.regular
        }

        switch string {
        case "ultraLight":
            return UIFont.Weight.ultraLight

        case "thin":
            return UIFont.Weight.thin

        case "light":
            return UIFont.Weight.light

        case "regular":
            return UIFont.Weight.regular

        case "medium":
            return UIFont.Weight.medium

        case "semiBold":
            return UIFont.Weight.semibold

        case "bold":
            return UIFont.Weight.bold

        case "heavy":
            return UIFont.Weight.heavy

        case "black":
            return UIFont.Weight.black

        default:
            return UIFont.Weight.regular
        }
    }
}
