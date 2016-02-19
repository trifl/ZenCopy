import Foundation

public class ZenCopy {
    public class Config {
        // ZenCopy will always check the languages in default order. If none pass, it will print the key.
        // It is a good idea to update this array such that the device locale is at index 0, and your default localse
        // is at the last index, though not necessary.
        public var languages = ["en"]
        
        // [language:[key:value]]
        // e.g. copy["en"]["profile.title"] = ["Hello world!"]
        // e.g. copy["en"]["profile.title"] = ["Hello ", "world!".style("token")]
        public private(set) var copy = [String:[String:[CopyComponent]]]()
        
        // Configure your own styles and set them here.
        // e.g. ZenCopy.manager.styles.append("header", Style(color: nil, font: UIFont(named:"something", size:14)))
        //      ZenCopy.manager.styles.append("bindleGreen", Style(color: ..., font: nil)
        public private(set) var styles = [String:Style]()
        
        public init() {
            
        }
        
        public func setCopy(language: String, copy: () -> [String:[CopyComponent]]) {
            self.copy[language] = copy()
        }
        
        public func addCopy(language: String, prefix: String = "", copy: () -> [String:[CopyComponent]]) {
            if self.copy[language] == nil {
                self.copy[language] = [String:[CopyComponent]]()
            }
    
            for (key, value) in copy() {
                let modifiedKey = prefix.characters.count > 0 ? "\(prefix).\(key)" : key
                self.copy[language]![modifiedKey] = value
            }
        }
        
        public func setStyles(styles: () -> [String:Style]) {
            self.styles = styles()
        }
    }
    
    public static let manager = Manager(config: Config())
    
    public class Manager {
        public var config: Config
        
        // applying a style only updates the non-nil values. In the order the styles are applied.
        public init(config: Config) {
            self.config = config
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
        
        // This will ignore style
        public func string(key key: String, args: [String] = []) -> String? {            
            var lang: String? = nil
            for language in config.languages {
                if let _ = config.copy[language]?[key] {
                    lang = language
                    break
                }
            }
            
            guard let language = lang else { return key }
            if let copyComponents = config.copy[language]?[key] {
                return string(copyComponents, args: args)
            } else {
                return nil
            }
        }
        
        // Get a styled string from `copy`
        public func attributedString(key key: String, args: [String]? = nil) -> NSAttributedString? {
            return NSAttributedString()
        }
        
        // Make an attributedString on the fly with CopyComponents
        public func attributedString(copyComponents: [CopyComponent]) -> NSAttributedString {
            return NSAttributedString(string: "")
        }
    }
}