//
//  TableHeaderFooterTheme.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 28/10/17.
//

import Foundation
import SwiftyJSON

extension StyleGuide {
    public class TableHeaderFooterTheme: ViewTheme {
        let textColor: UIColor?
        let font: UIFont?

        override init(fromJSON json: JSON) {

            self.textColor = StyleGuide.getColor(forString: json["textColor"].string)
            self.font = StyleGuide.getFont(fromString: json["font"].string)

            super.init(fromJSON: json)
        }
    }
}

extension UITableViewHeaderFooterView {

    override public func apply(theme: String) {
        if let values: StyleGuide.TableHeaderFooterTheme = StyleGuide.shared.tableHeaderFooterTheme[theme] {
            self.tintColor = values.tintColor ?? self.tintColor
            if let font = values.font {
                self.textLabel?.font = font
            }
            if let color = values.textColor {
                self.textLabel?.textColor = color
            }
        }
    }
}
