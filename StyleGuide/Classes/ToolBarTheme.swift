//
//  ToolBarTheme.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 28/10/17.
//

import Foundation
import SwiftyJSON

extension StyleGuide {
    public class ToolBarTheme: ViewTheme {
        override init(fromJSON json: JSON) {
            super.init(fromJSON: json)
        }
    }
}

extension UIToolbar {
    override public func apply(theme: String) {
        if let values = StyleGuide.shared.toolBarTheme[theme] {
            self.apply(viewThemeValues: values)
            self.tintColor = values.tintColor ?? self.tintColor
        }
    }
}
