//
//  NavigationBarTheme.swift
//  FBSnapshotTestCase
//
//  Created by Shubham Agrawal on 28/10/17.
//

import Foundation
import SwiftyJSON

extension StyleGuide {
    public class NavigationBarTheme: ViewTheme {

        let barTintColor: UIColor?
        let hideBottomLine: Bool
        let textColor: UIColor?
        let font: UIFont?

        override init(fromJSON json: JSON) {
            self.barTintColor = StyleGuide.parseColor(hexString: json["barTintColor"].string)
            self.hideBottomLine = json["hideBottomLine"].boolValue
            self.textColor = StyleGuide.parseColor(hexString: json["textColor"].string)
            self.font = StyleGuide.parseFont(from: json["font"].string)

            super.init(fromJSON: json)
        }
    }
}

extension UINavigationBar {
    override public func apply(theme: String) {
        if let values: StyleGuide.NavigationBarTheme = StyleGuide.shared.navigationBarTheme[theme] {
            self.apply(viewThemeValues: values)

            self.backgroundColor = nil
            self.barTintColor = values.backgroundColor ?? self.barTintColor

            if values.hideBottomLine == true {
                self.setBackgroundImage(UIImage(), for: .default)
                self.shadowImage = UIImage()
            }
            self.titleTextAttributes = [NSAttributedStringKey.foregroundColor: values.textColor ?? UIColor.black,
                                        NSAttributedStringKey.font: values.font ?? UIFont.systemFont(ofSize: 16)]
        }
    }
}
