//
//  StyleGuide.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 27/10/17.
//

import Foundation
import SwiftyJSON

public class StyleGuide {

    public static let shared: StyleGuide = StyleGuide()

    /// Theme file name. Set before calling initialize()
    public var themeFileName: String = "theme"

    typealias CustomViewTuple = (viewType: Themeable.Type, valuesType: ThemeValuesType.Type)
    private var customViews: [String: CustomViewTuple] = [:]

    public static let defaultThemeKey: String = "default"

    public var color: Colors!
    public var fonts: Fonts!

    public var viewTheme: [String: ViewTheme] = [:]
    public var textTheme: [String: TextTheme] = [:]
    public var buttonTheme: [String: ButtonTheme] = [:]
    public var switchTheme: [String: SwitchTheme] = [:]
    public var segmentedControlTheme: [String: SegmentedControlTheme] = [:]
    public var sliderTheme: [String: SliderTheme] = [:]
    public var activityIndicatorTheme: [String: ActivityIndicatorTheme] = [:]
    public var progressViewTheme: [String: ProgressViewTheme] = [:]
    public var navigationBarTheme: [String: NavigationBarTheme] = [:]
    public var refreshControlTheme: [String: RefreshControlTheme] = [:]
    public var applicationTheme: [String: ApplicationTheme] = [:]
    public var imageViewTheme: [String: ImageViewTheme] = [:]
    public var toolBarTheme: [String: ToolBarTheme] = [:]
    public var tableViewTheme: [String: TableViewTheme] = [:]
    public var barButtonTheme: [String: BarButtonTheme] = [:]
    public var searchBarTheme: [String: SearchBarTheme] = [:]
    public var tabBarTheme: [String: TabBarTheme] = [:]
    public var tableHeaderFooterTheme: [String: TableHeaderFooterTheme] = [:]

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

            //colors and fonts are to be parsed before everything else
            self.color = Colors(fromJSON: json["colors"])
            self.fonts = Fonts(fromJSON: json["fonts"])

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
                switchTheme[key] = SwitchTheme(fromJSON: value)
            })
            json["segmentedControl"].dictionary?.forEach({ (key: String, value: JSON) in
                segmentedControlTheme[key] = SegmentedControlTheme(fromJSON: value)
            })
            json["slider"].dictionary?.forEach({ (key: String, value: JSON) in
                sliderTheme[key] = SliderTheme(fromJSON: value)
            })
            json["activityIndicator"].dictionary?.forEach({ (key: String, value: JSON) in
                activityIndicatorTheme[key] = ActivityIndicatorTheme(fromJSON: value)
            })
            json["progressView"].dictionary?.forEach({ (key: String, value: JSON) in
                progressViewTheme[key] = ProgressViewTheme(fromJSON: value)
            })
            json["navigationBar"].dictionary?.forEach({ (key: String, value: JSON) in
                navigationBarTheme[key] = NavigationBarTheme(fromJSON: value)
            })
            json["refreshControl"].dictionary?.forEach({ (key: String, value: JSON) in
                refreshControlTheme[key] = RefreshControlTheme(fromJSON: value)
            })
            json["application"].dictionary?.forEach({ (key: String, value: JSON) in
                applicationTheme[key] = ApplicationTheme(fromJSON: value)
            })
            json ["imageView"].dictionary?.forEach({ (key: String, value: JSON) in
                imageViewTheme[key] = ImageViewTheme(fromJSON: value)
            })
            json["toolBar"].dictionary?.forEach({ (key: String, value: JSON) in
                toolBarTheme[key] = ToolBarTheme(fromJSON: value)
            })
            json["tableView"].dictionary?.forEach({ (key: String, value: JSON) in
                tableViewTheme[key] = TableViewTheme(fromJSON: value)
            })
            json["barButton"].dictionary?.forEach({ (key: String, value: JSON) in
                barButtonTheme[key] = BarButtonTheme(fromJSON: value)
            })
            json["searchBar"].dictionary?.forEach({ (key: String, value: JSON) in
                searchBarTheme[key] = SearchBarTheme(fromJSON: value)
            })
            json["tabBar"].dictionary?.forEach({ (key: String, value: JSON) in
                tabBarTheme[key] = TabBarTheme(fromJSON: value)
            })
            json["tableHeaderFooter"].dictionary?.forEach({ (key: String, value: JSON) in
                tableHeaderFooterTheme[key] = TableHeaderFooterTheme(fromJSON: value)
            })

            //Load custom views
            customViews.forEach { (viewKey: String, tuple: CustomViewTuple) in
                json[viewKey].dictionary?.forEach { (key: String, value: JSON) in
                    tuple.viewType.themeDict[key] = tuple.valuesType.initialize(fromJSON: value)
                }
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
                                                                            if let values: ApplicationTheme = self.applicationTheme[StyleGuide.defaultThemeKey] {
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
        UIImageView.appearance().apply(theme: StyleGuide.defaultThemeKey)

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
    public class func getFont(fromString string: String?) -> UIFont? {
        return StyleGuide.shared.fonts[string]
    }

    public class func getColor(forString string: String?) -> UIColor? {
        return StyleGuide.shared.color[string]
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
    static func initialize(fromJSON: JSON) -> ThemeValuesType
}


