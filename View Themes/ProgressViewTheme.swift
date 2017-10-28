//
//  ProgressViewTheme.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 28/10/17.
//

import Foundation
import SwiftyJSON

extension StyleGuide {
    public class ProgressViewTheme: ViewTheme {
        let alternateTintColor: UIColor?

        override init(fromJSON json: JSON) {
            self.alternateTintColor = StyleGuide.getColor(forString: json["alternateTintColor"].string)

            super.init(fromJSON: json)
        }
    }
}

extension UIProgressView {
    override public func apply(theme: String) {
        if let values: StyleGuide.ProgressViewTheme = StyleGuide.shared.progressViewTheme[theme] {
            self.apply(viewThemeValues: values)

            self.progressTintColor = values.tintColor ?? self.tintColor
            self.trackTintColor = values.alternateTintColor ?? self.trackTintColor
        }
    }
}
