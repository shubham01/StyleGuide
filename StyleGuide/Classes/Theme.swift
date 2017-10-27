//
//  Theme.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 27/10/17.
//

import Foundation

import SwiftyJSON

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

extension UILabel {

    public override func apply(theme: String) {
        if let values: StyleGuide.TextTheme = StyleGuide.shared.textTheme[theme] {
            self.apply(textThemeValues: values)
        }
    }

    public func apply(textThemeValues values: StyleGuide.TextTheme) {
        self.apply(viewThemeValues: values)

        self.textColor = values.textColor ?? self.textColor
        self.font = values.font ?? self.font
    }
}

extension UIButton {
    override public func apply(theme: String) {
        if let values: StyleGuide.ButtonTheme = StyleGuide.shared.buttonTheme[theme] {
            self.apply(buttonThemeValues: values)
        }
    }

    public func apply(buttonThemeValues values: StyleGuide.ButtonTheme) {
        self.apply(viewThemeValues: values)

        self.titleLabel?.font = values.font ?? self.titleLabel?.font
        self.backgroundColor = UIColor.clear
        if let textColor = values.textColor {
            self.setTitleColor(textColor, for: .normal)
            if let image = self.currentImage, image.renderingMode != .alwaysTemplate {
                self.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
            }
            self.tintColor = textColor
        }
        if let textColorPressed = values.textColorPressed {
            self.setTitleColor(textColorPressed, for: .highlighted)
        }
        if let textColorDisabled = values.textColorDisabled {
            self.setTitleColor(textColorDisabled, for: .disabled)
        }
        if let backgroundColor = values.backgroundColor {
            self.setBackgroundColor(color: backgroundColor, for: .normal)
        }
        if let backgroundColorPressed = values.backgroundColorPressed {
            self.setBackgroundColor(color: backgroundColorPressed, for: .highlighted)
        }
        if let backgroundColorDisabled = values.backgroundColorDisabled {
            self.setBackgroundColor(color: backgroundColorDisabled, for: .disabled)
        }
    }

    private func setBackgroundColor(color: UIColor, for state: UIControlState) {

        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.setBackgroundImage(colorImage, for: state)
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

extension UITextView {
    override public func apply(theme: String) {
        if let values: StyleGuide.TextTheme = StyleGuide.shared.textTheme[theme] {
            self.apply(textThemeValues: values)
        }
    }

    public func apply(textThemeValues values: StyleGuide.TextTheme) {
        self.apply(viewThemeValues: values)

        self.font = values.font ?? self.font
        self.textColor = values.textColor ?? self.textColor
    }
}

extension UISwitch {
    override public func apply(theme: String) {
        if let values: StyleGuide.Theme = StyleGuide.shared.switchTheme[theme] {
            self.tintColor = values.tintColor ?? self.tintColor
            self.thumbTintColor = values.thumbTintColor ?? self.thumbTintColor
            self.onTintColor = values.onTintColor ?? self.onTintColor
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

extension UITextField {
    override public func apply(theme: String) {
        if let values: StyleGuide.TextTheme = StyleGuide.shared.textTheme[theme] {

            self.apply(textThemeValues: values)
        }
    }

    public func apply(textThemeValues values: StyleGuide.TextTheme) {
        self.apply(viewThemeValues: values)

        self.textColor = values.textColor ?? self.textColor
        self.font = values.font ?? self.font
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
