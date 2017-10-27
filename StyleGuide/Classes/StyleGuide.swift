//
//  StyleGuide.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 27/10/17.
//

import Foundation
import SwiftyJSON

public class StyleGuide {

    public class ViewTheme {
        let backgroundColor: UIColor?
        let borderWidth: CGFloat?
        let borderColor: UIColor?
        let cornerRadius: CGFloat?
        let tintColor: UIColor?

        init(fromJSON json: JSON) {
            self.backgroundColor = StyleGuide.parseColor(hexString: json["backgroundColor"].string)
            self.borderWidth = StyleGuide.parseFloat(from: json["borderWidth"].int)
            self.cornerRadius = StyleGuide.parseFloat(from: json["cornerRadius"].int)
            self.tintColor = StyleGuide.parseColor(hexString: json["tintColor"].string)
            self.borderColor = StyleGuide.parseColor(hexString: json["borderColor"].string)
        }
    }

    public class TextTheme: ViewTheme {

        let textColor: UIColor?
        let font: UIFont?

        override init(fromJSON json: JSON) {

            self.textColor = StyleGuide.parseColor(hexString: json["textColor"].string)
            self.font = StyleGuide.parseFont(from: json["font"].string)

            super.init(fromJSON: json)
        }
    }

    public class ButtonTheme: ViewTheme {

        let textColor: UIColor?
        let textColorPressed: UIColor?
        let textColorDisabled: UIColor?
        let backgroundColorPressed: UIColor?
        let backgroundColorDisabled: UIColor?
        let font: UIFont?

        override init(fromJSON json: JSON) {
            self.textColor = StyleGuide.parseColor(hexString: json["textColor"].string)
            self.textColorPressed = StyleGuide.parseColor(hexString: json["textColorPressed"].string)
            self.textColorDisabled = StyleGuide.parseColor(hexString: json["textColorDisabled"].string)
            self.font = StyleGuide.parseFont(from: json["font"].string)
            backgroundColorPressed = StyleGuide.parseColor(hexString: json["backgroundColorPressed"].string)
            backgroundColorDisabled = StyleGuide.parseColor(hexString: json["backgroundColorDisabled"].string)

            super.init(fromJSON: json)
        }
    }

    public struct Theme {
        let backgroundColor: UIColor?
        let textColor: UIColor?
        let alternateTextColor: UIColor?
        let textColorPressed: UIColor?
        let textColorDisabled: UIColor?
        let backgroundColorPressed: UIColor?
        let backgroundColorDisabled: UIColor?
        let borderColor: UIColor?
        let onTintColor: UIColor?
        let tintColor: UIColor?
        let alternateTintColor: UIColor?
        let thumbTintColor: UIColor?
        let barTintColor: UIColor?
        let font: UIFont?
        let selectedFont: UIFont?
        let borderWidth: CGFloat?
        let cornerRadius: CGFloat?
        let hideBottomLine: Bool
        let separatorColor: UIColor?

        init(from json: JSON) {
            backgroundColor = StyleGuide.parseColor(hexString: json["backgroundColor"].string)
            textColor = StyleGuide.parseColor(hexString: json["textColor"].string)
            textColorPressed = StyleGuide.parseColor(hexString: json["textColorPressed"].string)
            textColorDisabled = StyleGuide.parseColor(hexString: json["textColorDisabled"].string)
            alternateTextColor = StyleGuide.parseColor(hexString: json["alternateTextColor"].string)
            font = StyleGuide.parseFont(from: json["font"].string)
            selectedFont = StyleGuide.parseFont(from: json["selectedFont"].string)
            borderColor = StyleGuide.parseColor(hexString: json["borderColor"].string)
            borderWidth = StyleGuide.parseFloat(from: json["borderWidth"].int)
            cornerRadius = StyleGuide.parseFloat(from: json["cornerRadius"].int)
            onTintColor = StyleGuide.parseColor(hexString: json["onTintColor"].string)
            tintColor = StyleGuide.parseColor(hexString: json["tintColor"].string)
            thumbTintColor = StyleGuide.parseColor(hexString: json["thumbTintColor"].string)
            alternateTintColor = StyleGuide.parseColor(hexString: json["alternateTintColor"].string)
            backgroundColorPressed = StyleGuide.parseColor(hexString: json["backgroundColorPressed"].string)
            backgroundColorDisabled = StyleGuide.parseColor(hexString: json["backgroundColorDisabled"].string)
            barTintColor = StyleGuide.parseColor(hexString: json["barTintColor"].string)
            hideBottomLine = json["hideBottomLine"].boolValue
            separatorColor = StyleGuide.parseColor(hexString: json["seperatorColor"].string)
        }
    }

    public static let shared: StyleGuide = StyleGuide()

    /// Theme file name. Set before calling initialize()
    public var themeFileName: String = "theme"

    typealias CustomViewTuple = (viewType: Themeable.Type, valuesType: ThemeValuesType.Type)
    private var customViews: [String: CustomViewTuple] = [:]

    public static let defaultThemeKey: String = "default"

    public var viewTheme: [String: ViewTheme] = [:]
    public var textTheme: [String: TextTheme] = [:]
    public var buttonTheme: [String: ButtonTheme] = [:]
    public var switchTheme: [String: Theme] = [:]
    public var segmentedControlTheme: [String: Theme] = [:]
    public var sliderTheme: [String: Theme] = [:]
    public var activityIndicatorTheme: [String: Theme] = [:]
    public var progressViewTheme: [String: Theme] = [:]
    public var navigationBarTheme: [String: Theme] = [:]
    public var refreshControlTheme: [String: Theme] = [:]
    public var applicationTheme: [String: Theme] = [:]
    public var imageViewTheme: [String: Theme] = [:]
    public var toolBarTheme: [String: Theme] = [:]
    public var tableViewTheme: [String: Theme] = [:]
    public var barButtonTheme: [String: Theme] = [:]
    public var searchBarTheme: [String: Theme] = [:]
    public var tabBarTheme: [String: Theme] = [:]
    public var tableHeaderFooterTheme: [String: Theme] = [:]

    public var primaryColor: UIColor?
    public var accentColor: UIColor?
    public var secondaryColor: UIColor?
    public var messageColor: UIColor?
    public var backgroundColor: UIColor?
    public var successColor: UIColor?
    public var errorColor: UIColor?
    public var warningColor: UIColor?
    public var primaryTextColor: UIColor?
    public var secondaryTextColor: UIColor?
    public var disabledTextColor: UIColor?
    public var reachGraphColor: UIColor?

    public var fontHeadlineBold: UIFont?
    public var fontHeadline: UIFont?
    public var fontHeadingSpecial: UIFont?
    public var fontBodySpecial: UIFont?
    public var fontHeading1: UIFont?
    public var fontHeading2: UIFont?
    public var fontHeading3: UIFont?
    public var fontHeading4: UIFont?
    public var fontHeading5: UIFont?
    public var fontHeading6: UIFont?
    public var fontBody1: UIFont?
    public var fontBody2: UIFont?
    public var fontBody3: UIFont?
    public var fontBody4: UIFont?
    public var fontBody5: UIFont?
    public var fontBody6: UIFont?

    private var windowObserver: NSObjectProtocol?

    /**
     Initialises the StyleGuide from JSON. Applies the appearance and application level theme.
     - note: Styleguide cannot be used without calling the initialize method
     */
    public func initialize() {
        loadFromJSON()
        setupApplicationTheme()
        setupAppearanceTheme()
    }

    /**
     Loads the styles from the JSON file
     */
    private func loadFromJSON() {
        if let fileURL: URL = Bundle.main.url(forResource: themeFileName, withExtension: "json"),
            let jsonData: Data = try? Data(contentsOf: fileURL) {

            let json: JSON = JSON(data: jsonData)

            json["text"].dictionary?.forEach({ (key: String, value: JSON) in
                textTheme[key] = TextTheme(fromJSON: value)
            })
            json["button"].dictionary?.forEach({ (key: String, value: JSON) in
                buttonTheme[key] = ButtonTheme(fromJSON: value)
            })
            json["view"].dictionary?.forEach({ (key: String, value: JSON) in
                viewTheme[key] = ViewTheme(fromJSON: value)
            })
            json["switch"].dictionary?.forEach({ (key: String, value: JSON) in
                switchTheme[key] = Theme(from: value)
            })
            json["segmentedControl"].dictionary?.forEach({ (key: String, value: JSON) in
                segmentedControlTheme[key] = Theme(from: value)
            })
            json["slider"].dictionary?.forEach({ (key: String, value: JSON) in
                sliderTheme[key] = Theme(from: value)
            })
            json["activityIndicator"].dictionary?.forEach({ (key: String, value: JSON) in
                activityIndicatorTheme[key] = Theme(from: value)
            })
            json["progressView"].dictionary?.forEach({ (key: String, value: JSON) in
                progressViewTheme[key] = Theme(from: value)
            })
            json["navigationBar"].dictionary?.forEach({ (key: String, value: JSON) in
                navigationBarTheme[key] = Theme(from: value)
            })
            json["refreshControl"].dictionary?.forEach({ (key: String, value: JSON) in
                refreshControlTheme[key] = Theme(from: value)
            })
            json["application"].dictionary?.forEach({ (key: String, value: JSON) in
                applicationTheme[key] = Theme(from: value)
            })
            json ["imageView"].dictionary?.forEach({ (key: String, value: JSON) in
                imageViewTheme[key] = Theme(from: value)
            })
            json["toolbar"].dictionary?.forEach({ (key: String, value: JSON) in
                toolBarTheme[key] = Theme(from: value)
            })
            json["tableview"].dictionary?.forEach({ (key: String, value: JSON) in
                tableViewTheme[key] = Theme(from: value)
            })
            json["barButton"].dictionary?.forEach({ (key: String, value: JSON) in
                barButtonTheme[key] = Theme(from: value)
            })
            json["searchBar"].dictionary?.forEach({ (key: String, value: JSON) in
                searchBarTheme[key] = Theme(from: value)
            })
            json["tabBar"].dictionary?.forEach({ (key: String, value: JSON) in
                tabBarTheme[key] = Theme(from: value)
            })
            json["tableHeaderFooter"].dictionary?.forEach({ (key: String, value: JSON) in
                tableHeaderFooterTheme[key] = Theme(from: value)
            })

            //Load custom view
            customViews.forEach { (viewKey: String, tuple: CustomViewTuple) in
                json[viewKey].dictionary?.forEach { (key: String, value: JSON) in
                    tuple.viewType.themeDict[key] = tuple.valuesType.initialize(from: value)
                }
            }

            if let colors: JSON = json["colors"] {
                accentColor = StyleGuide.parseColor(hexString: colors["accent"].string)
                primaryColor = StyleGuide.parseColor(hexString: colors["primary"].string)
                secondaryColor = StyleGuide.parseColor(hexString: colors["secondary"].string)
                messageColor = StyleGuide.parseColor(hexString: colors["message"].string)
                backgroundColor = StyleGuide.parseColor(hexString: colors["background"].string)
                successColor = StyleGuide.parseColor(hexString: colors["success"].string)
                errorColor = StyleGuide.parseColor(hexString: colors["error"].string)
                warningColor = StyleGuide.parseColor(hexString: colors["warning"].string)
                primaryTextColor = StyleGuide.parseColor(hexString: colors["primaryText"].string)
                secondaryTextColor = StyleGuide.parseColor(hexString: colors["secondaryText"].string)
                disabledTextColor = StyleGuide.parseColor(hexString: colors["disabledText"].string)
                reachGraphColor = StyleGuide.parseColor(hexString: colors["reachGraphColor"].string)
            }

            if let fonts: JSON = json["fonts"] {
                fontHeadline = StyleGuide.parseFont(from: fonts["headline"].string)
                fontHeadlineBold = StyleGuide.parseFont(from: fonts["headlineBold"].string)
                fontHeadingSpecial = StyleGuide.parseFont(from: fonts["headingSpecial"].string)
                fontBodySpecial = StyleGuide.parseFont(from: fonts["bodySpecial"].string)
                fontHeading1 = StyleGuide.parseFont(from: fonts["heading1"].string)
                fontHeading2 = StyleGuide.parseFont(from: fonts["heading2"].string)
                fontHeading3 = StyleGuide.parseFont(from: fonts["heading3"].string)
                fontHeading4 = StyleGuide.parseFont(from: fonts["heading4"].string)
                fontHeading5 = StyleGuide.parseFont(from: fonts["heading5"].string)
                fontHeading6 = StyleGuide.parseFont(from: fonts["heading6"].string)
                fontBody1 = StyleGuide.parseFont(from: fonts["body1"].string)
                fontBody2 = StyleGuide.parseFont(from: fonts["body2"].string)
                fontBody3 = StyleGuide.parseFont(from: fonts["body3"].string)
                fontBody4 = StyleGuide.parseFont(from: fonts["body4"].string)
                fontBody5 = StyleGuide.parseFont(from: fonts["body5"].string)
                fontBody6 = StyleGuide.parseFont(from: fonts["body6"].string)
            }
        }
    }

    /**
     Set the application level theme
     */
    private func setupApplicationTheme() {
        if self.windowObserver == nil {
            windowObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.UIWindowDidBecomeVisible,
                                                                    object: nil, queue: nil, using: { (notification) in
                                                                        if let window = notification.object as? UIWindow {
                                                                            if let values: Theme = self.applicationTheme[StyleGuide.defaultThemeKey] {
                                                                                window.tintColor = values.tintColor ?? window.tintColor
                                                                            }
                                                                        }
            })
        }
    }

    /**
     Set the appearance theme
     */
    private func setupAppearanceTheme() {
        UISwitch.appearance().apply(theme: StyleGuide.defaultThemeKey)
        UISegmentedControl.appearance().apply(theme: StyleGuide.defaultThemeKey)
        UIProgressView.appearance().apply(theme: StyleGuide.defaultThemeKey)
        UISlider.appearance().apply(theme: StyleGuide.defaultThemeKey)
        UIActivityIndicatorView.appearance().apply(theme: StyleGuide.defaultThemeKey)
        UINavigationBar.appearance().apply(theme: StyleGuide.defaultThemeKey)
        UINavigationBar.appearance().isTranslucent = false
        UIRefreshControl.appearance().apply(theme: StyleGuide.defaultThemeKey)
        UISearchBar.appearance().apply(theme: StyleGuide.defaultThemeKey)
        UITabBar.appearance().apply(theme: StyleGuide.defaultThemeKey)

        //Set tab bar item appearance
        if let font = tabBarTheme[StyleGuide.defaultThemeKey]?.font {
            let attributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: font]
            UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .selected)

        }
    }

    /**
     Call the method to load styles from the theme json file
     - NOTE: Custom views must be registered BEFORE initialising the StyleGuide
     - parameter view: View class for the custom view
     - parameter key: Key string for the custom view in json file
     - parameter valuesType: The structure or class to store the theme attributes into
     */
    public func register(customView: Themeable.Type, key: String, valuesType: ThemeValuesType.Type) {
        customViews[key] = CustomViewTuple(viewType: customView, valuesType: valuesType)
    }

    /**
     Parse font from string to UIFont object
     - parameter from: The input font string in format -> "size,fontName"
     - returns: UIFont object if successful, nil otherwise. If font name is not specified, system font of asked size is returned.
     */
    public class func parseFont(from string: String?) -> UIFont? {
        //if size is not given, return nil
        if let values = string?.components(separatedBy: ","),
            let sizeString = values.first, let fontSize = NumberFormatter().number(from: sizeString) {
            let size = CGFloat(fontSize)

            if let fontName = values.last {
                return UIFont(name: fontName, size: size)
            }
            //if font name is not specified, return system font with the asked size
            return UIFont.systemFont(ofSize: size)
        }
        return nil
    }

    /**
     Parse color in hex string format to UIColor
     - parameter hexString: The color hex code in format #RRGGBB or #AARRGGBB
     - returns: UIColor? if hexString is not nil, returns nil otherwise
     */
    public class func parseColor(hexString: String?) -> UIColor? {
        guard let string = hexString else {
            return nil
        }
        return UIColor(hexString: string)
    }

    /**
     Utility method to convert `Int` to `CGFloat`.
     - parameter int: The integer to be parsed to `CGFloat`
     - returns: `CGFloat?` if integer is not nil, returns nil otherwise
     */
    public class func parseFloat(from int: Int?) -> CGFloat? {
        if let intValue = int {
            return CGFloat(intValue)
        }
        return nil
    }

    deinit {
        if let observer = self.windowObserver {
            NotificationCenter.default.removeObserver(observer)
            self.windowObserver = nil
        }
    }
}

public protocol Themeable {
    static var themeDict: [String: ThemeValuesType] { get set }
    func apply(theme: String)
}

public protocol ThemeValuesType {
    static func initialize(from: JSON) -> ThemeValuesType
}
