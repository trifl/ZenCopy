import Foundation

public let manager = Manager(config: Config())

public class Manager {
    public var config: Config
    
    // applying a style only updates the non-nil values. In the order the styles are applied.
    public init(config: Config) {
        self.config = config
    }
    
    // This will ignore style
    public func string(key key: String, args: [String] = []) -> String? {
        guard let language = firstAvailableLanguage(key: key) else { return key }
        guard let copyComponents = config._copy[language]?[key] ?? config.copy?(locale: language, key: key) else { return nil }
        return string(copyComponents, args: args)
    }
    
    // Get a styled (attributed) string from `copy`
    public func attributedString(key key: String, args: [String] = []) -> NSAttributedString? {
        guard let language = firstAvailableLanguage(key: key) else { return NSAttributedString(string: key) }
        guard let copyComponents = config._copy[language]?[key] ?? config.copy?(locale: language, key: key) else { return nil }
        return attributedString(copyComponents, args: args)
    }
    
    public func string(copyComponents: [CopyComponent], args: [String] = []) -> String {
        var string = ""
        //combine copyComponents without their style
        for component in copyComponents {
            // check for args in component
            // TODO: this isn't very efficient. Consider an algorithm that does this in one pass, instead of n
            var value = component.value
            for (index, arg) in args.enumerate() {
                value = value.stringByReplacingOccurrencesOfString("$\(index)", withString: arg)
            }
            string += value
        }
        return string
    }
    
    internal func styleNamesFromStyleString(styleString: String) -> [String] {
        return styleString.componentsSeparatedByString(" ")
    }
    
    // Make an attributedString on the fly with CopyComponents
    public func attributedString(copyComponents: [CopyComponent], args: [String] = []) -> NSAttributedString {
        let string = NSMutableAttributedString()
        for component in copyComponents {
            var value = component.value
            for (index, arg) in args.enumerate() {
                value = value.stringByReplacingOccurrencesOfString("$\(index)", withString: arg)
            }
            
            var style = component.style
            if style == nil {
                if let styleName = component.styleName {
                    // multiple styles are possible
                    for styleName in styleNamesFromStyleString(styleName) {
                        if style == nil {
                            style = config.styles?(name: styleName)
                        } else {
                            style!.append(config.styles?(name: styleName))
                        }
                    }
                }
            }

            let attributes = attributesForStyle(style)
            let attributedValue = NSAttributedString(string: value, attributes: attributes)
            string.appendAttributedString(attributedValue)
        }
        return string
    }
    
    // MARK: - Private
    private func firstAvailableLanguage(key key: String) -> String? {
        var lang: String? = nil
        for language in config.languages {
            if let _ = config._copy[language]?[key] ?? config.copy?(locale: language, key: key) {
                lang = language
                break
            }
        }
        return lang
    }
    
    internal func attributesForStyle(style: Style?) -> [String : AnyObject]? {
        guard let style = style else { return nil }

        // if there is no size, use 12
        var font: UIFont!
        let fontSize = style.fontSize ?? 12
        if let fontName = style.fontName {
            font = UIFont(name: fontName, size: fontSize)
        } else {
            font = UIFont.systemFontOfSize(fontSize)
        }
        
        var attributes = [String : AnyObject]()
        attributes[NSForegroundColorAttributeName] = style.color
        attributes[NSFontAttributeName] = font
        return attributes
    }
}
