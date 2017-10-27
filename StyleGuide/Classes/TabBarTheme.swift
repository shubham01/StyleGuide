//
//  TabBarTheme.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 28/10/17.
//

import Foundation
import SwiftyJSON

extension StyleGuide {
    public class TabBarTheme: ViewTheme {
        let font: UIFont?

        override init(fromJSON json: JSON) {
            font = StyleGuide.parseFont(from: json["font"].string)
            super.init(fromJSON: json)
        }
    }
}

extension UITabBar {
    override public func apply(theme: String) {
        if let values: StyleGuide.TabBarTheme = StyleGuide.shared.tabBarTheme[theme] {
            self.barTintColor = values.backgroundColor ?? self.barTintColor
            self.tintColor = values.tintColor ?? self.tintColor
        }
    }
}
