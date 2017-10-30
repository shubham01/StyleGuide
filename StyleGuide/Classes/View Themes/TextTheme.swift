//
//  TextTheme.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 27/10/17.
//

import Foundation
import SwiftyJSON

extension StyleGuide {
    public class TextTheme: ViewTheme {

        let textColor: UIColor?
        let font: UIFont?

        override init(fromJSON json: JSON) {

            self.textColor = StyleGuide.getColor(forString: json["textColor"].string)
            self.font = StyleGuide.getFont(fromString: json["font"].string)

            super.init(fromJSON: json)
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
