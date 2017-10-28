//
//  SegmentedControlTheme.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 28/10/17.
//

import Foundation
import SwiftyJSON

extension StyleGuide {
    public class SegmentedControlTheme: ViewTheme {
        let textColor: UIColor?
        let alternateTextColor: UIColor?
        let font: UIFont?
        let selectedFont: UIFont?

        override init(fromJSON json: JSON) {
            self.textColor = StyleGuide.parseColor(hexString: json["textColor"].string)
            self.alternateTextColor = StyleGuide.parseColor(hexString: json["alternateTextColor"].string)
            self.font = StyleGuide.parseFont(from: json["font"].string)
            self.selectedFont = StyleGuide.parseFont(from: json["selectedFont"].string)
            
            super.init(fromJSON: json)
        }
    }
}

extension UISegmentedControl {
    override public func apply(theme: String) {
        if let values: StyleGuide.SegmentedControlTheme = StyleGuide.shared.segmentedControlTheme[theme] {
            self.apply(segmentedControlThemeValues: values)
        }
    }

    public func apply(segmentedControlThemeValues values: StyleGuide.SegmentedControlTheme) {
        self.apply(viewThemeValues: values)

        //for normal state
        var attributesNormal: [AnyHashable: Any] = [:]
        if let font = values.font {
            attributesNormal[NSAttributedStringKey.font] = font
        }
        if let color = values.textColor {
            attributesNormal[NSAttributedStringKey.foregroundColor] = color
        }
        self.setTitleTextAttributes(attributesNormal, for: .normal)

        //for selected state
        var attributesSelected: [AnyHashable: Any] = [:]
        if let font = values.selectedFont {
            attributesSelected[NSAttributedStringKey.font] = font
        }
        if let color = values.alternateTextColor {
            attributesSelected[NSAttributedStringKey.foregroundColor] = color
        }
        self.setTitleTextAttributes(attributesSelected, for: .selected)
    }
}
