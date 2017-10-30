//
//  ButtonTheme.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 27/10/17.
//

import Foundation
import SwiftyJSON

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

extension StyleGuide {
    public class ButtonTheme: ViewTheme {

        let textColor: UIColor?
        let textColorPressed: UIColor?
        let textColorDisabled: UIColor?
        let backgroundColorPressed: UIColor?
        let backgroundColorDisabled: UIColor?
        let font: UIFont?

        override init(fromJSON json: JSON) {
            self.textColor = StyleGuide.getColor(forString: json["textColor"].string)
            self.textColorPressed = StyleGuide.getColor(forString: json["textColorPressed"].string)
            self.textColorDisabled = StyleGuide.getColor(forString: json["textColorDisabled"].string)
            self.font = StyleGuide.parseFont(from: json["font"].string)
            backgroundColorPressed = StyleGuide.getColor(forString: json["backgroundColorPressed"].string)
            backgroundColorDisabled = StyleGuide.getColor(forString: json["backgroundColorDisabled"].string)

            super.init(fromJSON: json)
        }
    }
}
