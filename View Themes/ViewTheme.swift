//
//  Theme.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 27/10/17.
//

import Foundation

import SwiftyJSON

extension StyleGuide {
    public class ViewTheme {
        let backgroundColor: UIColor?
        let borderWidth: CGFloat?
        let borderColor: UIColor?
        let cornerRadius: CGFloat?
        let tintColor: UIColor?

        init(fromJSON json: JSON) {
            self.backgroundColor = StyleGuide.parseColor(hexString: json["backgroundColor"].string)
            self.borderWidth = StyleGuide.parseFloat(from: json["borderWidth"].int)
            self.cornerRadius = StyleGuide.parseFloat(from: json["cornerRadius"].int)
            self.tintColor = StyleGuide.parseColor(hexString: json["tintColor"].string)
            self.borderColor = StyleGuide.parseColor(hexString: json["borderColor"].string)
        }
    }
}

extension UIView {
    @objc public func apply(theme: String) {
        if let values: StyleGuide.ViewTheme = StyleGuide.shared.viewTheme[theme] {
            self.apply(viewThemeValues: values)
        }
    }

    public func apply(viewThemeValues values: StyleGuide.ViewTheme) {
        self.backgroundColor = values.backgroundColor ?? self.backgroundColor
        self.viewBorderWidth = values.borderWidth ?? self.viewBorderWidth
        self.viewCornerRadius = values.cornerRadius ?? self.viewCornerRadius
        self.viewBorderColor = values.borderColor ?? self.viewBorderColor
        self.tintColor = values.tintColor ?? self.tintColor
    }

    @IBInspectable public var themeStyle: String {
        get {
            return ""
        }
        set {
            self.apply(theme: newValue)
        }
    }
}
