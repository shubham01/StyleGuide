//
//  TableViewTheme.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 28/10/17.
//

import Foundation
import SwiftyJSON

extension StyleGuide {
    public class TableViewTheme: ViewTheme {
        let separatorColor: UIColor?

        override init(fromJSON json: JSON) {
            self.separatorColor = StyleGuide.getColor(forString: json["seperatorColor"].string)

            super.init(fromJSON: json)
        }
    }
}

extension UITableView {
    override public func apply(theme: String) {
        if let values: StyleGuide.TableViewTheme = StyleGuide.shared.tableViewTheme[theme] {
            
            self.apply(viewThemeValues: values)

            self.separatorColor = values.separatorColor ?? self.separatorColor
        }
    }
}
