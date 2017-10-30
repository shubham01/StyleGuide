//
//  SwitchTheme.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 27/10/17.
//

import Foundation
import SwiftyJSON

extension StyleGuide {
    public class SwitchTheme: ViewTheme {
        let onTintColor: UIColor?
        let thumbTintColor: UIColor?

        override init(fromJSON json: JSON) {
            onTintColor = StyleGuide.getColor(forString: json["onTintColor"].string)
            thumbTintColor = StyleGuide.getColor(forString: json["thumbTintColor"].string)

            super.init(fromJSON: json)
        }
    }
}

extension UISwitch {
    override public func apply(theme: String) {
        if let values: StyleGuide.SwitchTheme = StyleGuide.shared.switchTheme[theme] {
            self.apply(switchThemeValues: values)
        }
    }

    public func apply(switchThemeValues values: StyleGuide.SwitchTheme) {
        self.apply(viewThemeValues: values)

        self.thumbTintColor = values.thumbTintColor ?? self.thumbTintColor
        self.onTintColor = values.onTintColor ?? self.onTintColor
    }
}
