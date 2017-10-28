//
//  Colors.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 28/10/17.
//

import Foundation
import SwiftyJSON

extension StyleGuide {
    public class Colors {

        private var colors: [String: UIColor]

        init(fromJSON json: JSON) {
            var colors: [String: UIColor] = [:]
            json.dictionary?.forEach({ (colorName: String, colorValue: JSON) in
                if let colorString = colorValue.string?.trimmingCharacters(in: .whitespaces) {
                    if let color = StyleGuide.parseColor(hexString: colorString) {
                        colors[colorName] = color
                    }
                }
            })
            self.colors = colors
        }

        subscript(colorName: String) -> UIColor? {
            return self.colors[colorName]
        }
    }
}
