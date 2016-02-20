import Foundation

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