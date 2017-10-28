//
//  File.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 28/10/17.
//

import Foundation
import SwiftyJSON

extension StyleGuide {
    public class SliderTheme: ViewTheme {
        let alternateTintColor: UIColor?
        let thumbTintColor: UIColor?

        override init(fromJSON json: JSON) {
            self.thumbTintColor = StyleGuide.getColor(forString: json["thumbTintColor"].string)
            self.alternateTintColor = StyleGuide.getColor(forString: json["alternateTintColor"].string)

            super.init(fromJSON: json)
        }
    }
}

extension UISlider {
    override public func apply(theme: String) {
        if let values: StyleGuide.SliderTheme = StyleGuide.shared.sliderTheme[theme] {
            self.apply(sliderThemeValues: values)
        }
    }

    public func apply(sliderThemeValues values: StyleGuide.SliderTheme) {
        self.apply(viewThemeValues: values)

        self.maximumTrackTintColor = values.alternateTintColor ?? self.maximumTrackTintColor
        self.thumbTintColor = values.thumbTintColor ?? self.thumbTintColor
    }
}
