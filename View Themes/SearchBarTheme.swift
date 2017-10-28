//
//  SearchBarTheme.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 28/10/17.
//

import Foundation
import SwiftyJSON

extension StyleGuide {
    public class SearchBarTheme: ViewTheme {
        let textColor: UIColor?
        let font: UIFont?

        override init(fromJSON json: JSON) {
            textColor = StyleGuide.parseColor(hexString: json["textColor"].string)
            font = StyleGuide.parseFont(from: json["font"].string)

            super.init(fromJSON: json)
        }
    }
}

extension UISearchBar {
    override public func apply(theme: String) {
        if let values: StyleGuide.SearchBarTheme = StyleGuide.shared.searchBarTheme[theme] {
            self.apply(viewThemeValues: values)

            self.backgroundColor = UIColor.clear
            self.barTintColor = values.backgroundColor ?? self.barTintColor
            if let searchField = self.value(forKey: "searchField") as? UITextField {
                searchField.font = values.font ?? searchField.font
                searchField.textColor = values.textColor ?? searchField.textColor
            }
        }
    }
}
