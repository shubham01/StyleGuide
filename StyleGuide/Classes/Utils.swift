//
//  Utils.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 28/10/17.
//

import Foundation
import SwiftyJSON

public class Utils {
    class func getVariableName(fromString string: String) -> String? {
        let string = string.trimmingCharacters(in: .whitespaces)
        if string.first == "@" {
            let fromIndex = string.index(string.startIndex, offsetBy: 1)
            return string.substring(from: fromIndex)
        }
        return nil
    }
}
