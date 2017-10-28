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
        public var primary: UIColor?
        public var accent: UIColor?
        public var secondary: UIColor?
        public var background: UIColor?
        public var success: UIColor?
        public var error: UIColor?
        public var warning: UIColor?
        public var primaryText: UIColor?
        public var secondaryText: UIColor?
        public var disabledText: UIColor?

        init(fromJSON json: JSON) {
            self.accent = StyleGuide.parseColor(hexString: json["accent"].string)
            self.primary = StyleGuide.parseColor(hexString: json["primary"].string)
            self.secondary = StyleGuide.parseColor(hexString: json["secondary"].string)
            self.background = StyleGuide.parseColor(hexString: json["background"].string)
            self.success = StyleGuide.parseColor(hexString: json["success"].string)
            self.error = StyleGuide.parseColor(hexString: json["error"].string)
            self.warning = StyleGuide.parseColor(hexString: json["warning"].string)
            self.primaryText = StyleGuide.parseColor(hexString: json["primaryText"].string)
            self.secondaryText = StyleGuide.parseColor(hexString: json["secondaryText"].string)
            self.disabledText = StyleGuide.parseColor(hexString: json["disabledText"].string)
        }
    }
}
