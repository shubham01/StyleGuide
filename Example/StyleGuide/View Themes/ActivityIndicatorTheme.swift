//
//  ActivityIndicatorTheme.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 28/10/17.
//

import Foundation
import SwiftyJSON

extension StyleGuide {
    public class ActivityIndicatorTheme: ViewTheme {
        override init(fromJSON json: JSON) {
            super.init(fromJSON: json)
        }
    }
}

extension UIActivityIndicatorView {
    override public func apply(theme: String) {
        if let values: StyleGuide.ActivityIndicatorTheme = StyleGuide.shared.activityIndicatorTheme[theme] {
            self.apply(viewThemeValues: values)
            self.color = values.tintColor ?? self.color
        }
    }
}
