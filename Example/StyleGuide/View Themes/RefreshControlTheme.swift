//
//  RefreshControlTheme.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 28/10/17.
//

import Foundation
import SwiftyJSON

extension StyleGuide {
    public class RefreshControlTheme: ViewTheme {

        override init(fromJSON json: JSON) {
            super.init(fromJSON: json)
        }
    }
}

extension UIRefreshControl {
    override public func apply(theme: String) {
        if let values: StyleGuide.RefreshControlTheme = StyleGuide.shared.refreshControlTheme[theme] {
            self.tintColor = values.tintColor
        }
    }
}
