//
//  ImageViewTheme.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 28/10/17.
//

import Foundation
import SwiftyJSON

extension StyleGuide {
    public class ImageViewTheme: ViewTheme {

        override init(fromJSON json: JSON) {
            super.init(fromJSON: json)
        }
    }
}

extension UIImageView {
    override public func apply(theme: String) {
        if let values: StyleGuide.ImageViewTheme = StyleGuide.shared.imageViewTheme[theme] {
            if let color = values.tintColor {
                if let image = self.image, image.renderingMode != .alwaysTemplate {
                    self.image = image.withRenderingMode(.alwaysTemplate)
                }
                self.tintColor = color
            }
        }
    }
    @IBInspectable override public var themeStyle: String {
        get {
            return ""
        }
        set {
            self.apply(theme: newValue)
        }
    }
}
