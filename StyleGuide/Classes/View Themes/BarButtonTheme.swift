//
//  BarButtonTheme.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 28/10/17.
//

import Foundation
import SwiftyJSON

extension StyleGuide {
    public class BarButtonTheme: ViewTheme {
        let font: UIFont?

        override init(fromJSON json: JSON) {
            self.font = StyleGuide.getFont(fromString: json["font"].string)
            super.init(fromJSON: json)
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
        if let values: StyleGuide.BarButtonTheme = StyleGuide.shared.barButtonTheme[theme] {
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
