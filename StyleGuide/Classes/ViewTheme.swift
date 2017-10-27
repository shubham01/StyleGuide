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

extension UISegmentedControl {
    override public func apply(theme: String) {
        if let values: StyleGuide.Theme = StyleGuide.shared.segmentedControlTheme[theme] {

            self.tintColor = values.tintColor ?? self.tintColor

            //for normal state
            var attributesNormal: [AnyHashable: Any] = [:]
            if let font = values.font {
                attributesNormal[NSAttributedStringKey.font] = font
            }
            if let color = values.textColor {
                attributesNormal[NSAttributedStringKey.foregroundColor] = color
            }
            self.setTitleTextAttributes(attributesNormal, for: .normal)

            //for selected state
            var attributesSelected: [AnyHashable: Any] = [:]
            if let font = values.selectedFont {
                attributesSelected[NSAttributedStringKey.font] = font
            }
            if let color = values.alternateTextColor {
                attributesSelected[NSAttributedStringKey.foregroundColor] = color
            }
            self.setTitleTextAttributes(attributesSelected, for: .selected)
        }
    }
}

extension UISlider {
    override public func apply(theme: String) {
        if let values: StyleGuide.Theme = StyleGuide.shared.sliderTheme[theme] {
            self.tintColor = values.tintColor ?? self.tintColor
            self.maximumTrackTintColor = values.alternateTintColor ?? self.maximumTrackTintColor
            self.thumbTintColor = values.thumbTintColor ?? self.thumbTintColor
        }
    }
}

extension UIActivityIndicatorView {
    override public func apply(theme: String) {
        if let values: StyleGuide.Theme = StyleGuide.shared.activityIndicatorTheme[theme] {
            self.color = values.tintColor ?? self.color
        }
    }
}

extension UIProgressView {
    override public func apply(theme: String) {
        if let values: StyleGuide.Theme = StyleGuide.shared.progressViewTheme[theme] {
            self.progressTintColor = values.tintColor ?? self.tintColor
            self.trackTintColor = values.alternateTintColor ?? self.trackTintColor
        }
    }
}

extension UINavigationBar {
    override public func apply(theme: String) {
        if let values: StyleGuide.Theme = StyleGuide.shared.navigationBarTheme[theme] {
            self.barTintColor = values.barTintColor ?? self.barTintColor
            self.tintColor = values.tintColor ?? self.tintColor
            if values.hideBottomLine == true {
                self.setBackgroundImage(UIImage(), for: .default)
                self.shadowImage = UIImage()
            }
            self.titleTextAttributes = [NSAttributedStringKey.foregroundColor: values.textColor ?? UIColor.black,
                                        NSAttributedStringKey.font: values.font ?? UIFont.systemFont(ofSize: 16)]
        }
    }
}

extension UIRefreshControl {
    override public func apply(theme: String) {
        if let values: StyleGuide.Theme = StyleGuide.shared.refreshControlTheme[theme] {
            self.tintColor = values.tintColor
        }
    }
}

extension UIToolbar {
    override public func apply(theme: String) {
        if let values = StyleGuide.shared.toolBarTheme[theme] {
            self.tintColor = values.tintColor ?? self.tintColor
        }
    }
}

extension UITableView {
    override public func apply(theme: String) {
        if let values = StyleGuide.shared.tableViewTheme[theme] {
            self.backgroundColor = values.backgroundColor ?? self.backgroundColor
            self.separatorColor = values.separatorColor ?? self.separatorColor
        }
    }
}

extension UIBarButtonItem {
    @IBInspectable var themeStyle: String {
        get {
            return ""
        }
        set {
            self.apply(theme: newValue)
        }
    }

    func apply(theme: String) {
        if let values: StyleGuide.Theme = StyleGuide.shared.barButtonTheme[theme] {
            self.tintColor = values.tintColor ?? self.tintColor
            self.title = self.title?.uppercased()
            let attrs: [NSAttributedStringKey: Any?] = [
                NSAttributedStringKey.foregroundColor: values.tintColor,
                NSAttributedStringKey.font: values.font
            ]
            self.setTitleTextAttributes(attrs, for: .normal)
        }
    }

}

extension UIImageView {
    override public func apply(theme: String) {
        if let values: StyleGuide.Theme = StyleGuide.shared.imageViewTheme[theme] {
            if let color = values.tintColor {
                if let image = self.image, image.renderingMode != .alwaysTemplate {
                    self.image = image.withRenderingMode(.alwaysTemplate)
                }
                self.tintColor = color
            }
        }
    }
    @IBInspectable override public var themeStyle: String {
        get {
            return ""
        }
        set {
            self.apply(theme: newValue)
        }
    }
}

extension UISearchBar {
    override public func apply(theme: String) {
        if let values = StyleGuide.shared.searchBarTheme[theme] {
            self.tintColor = values.tintColor ?? self.tintColor
            self.barTintColor = values.backgroundColor ?? self.barTintColor
            if let searchField = self.value(forKey: "searchField") as? UITextField {
                searchField.font = values.font ?? searchField.font
                searchField.textColor = values.textColor ?? searchField.textColor
            }
        }
    }
}

extension UITabBar {
    override public func apply(theme: String) {
        if let values: StyleGuide.Theme = StyleGuide.shared.tabBarTheme[theme] {
            self.barTintColor = values.backgroundColor ?? self.barTintColor
            self.tintColor = values.tintColor ?? self.tintColor
        }
    }
}

extension UITableViewHeaderFooterView {
    override public func apply(theme: String) {
        if let values: StyleGuide.Theme = StyleGuide.shared.tableHeaderFooterTheme[theme] {
            self.tintColor = values.tintColor ?? self.tintColor
            if let font = values.font {
                self.textLabel?.font = font
            }
            if let color = values.textColor {
                self.textLabel?.textColor = color
            }
        }
    }
}
