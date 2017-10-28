//
//  Fonts.swift
//  FBSnapshotTestCase
//
//  Created by Shubham Agrawal on 28/10/17.
//

import Foundation
import SwiftyJSON

extension StyleGuide {
    public class Fonts {
        private var fonts: [String: UIFont]

        init(fromJSON json: JSON) {
            var fonts: [String: UIFont] = [:]
            json.dictionary?.forEach({ (fontName: String, fontValue: JSON) in
                if let font = Utils.parseFont(from: fontValue.string?.trimmingCharacters(in: .whitespaces)) {
                    fonts[fontName] = font
                }
            })
            self.fonts = fonts
        }

        subscript(fontName: String?) -> UIFont? {
            guard let fontName = fontName else {
                return nil
            }

            //if the font is named, return the stored value otherwise parse the font
            if let varName = Utils.parseVariableName(fromString: fontName) {
                return self.fonts[varName]
            } else {
                return Utils.parseFont(from: fontName)
            }
        }
    }
}
