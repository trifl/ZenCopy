import Foundation

public class Config {
    // ZenCopy will always check the languages in default order. If none pass, it will print the key.
    // It is a good idea to update this array such that the device locale is at index 0, and your default localse
    // is at the last index, though not necessary.
    public var languages = ["en"]
    
    // [language:[key:value]]
    // e.g. copy["en"]["profile.title"] = ["Hello world!"]
    // e.g. copy["en"]["profile.title"] = ["Hello ", "world!".style("token")]
    internal var _copy = [String:[String:[CopyComponent]]]()
    public var copy: ((locale: String, key: String) -> [CopyComponent]?)?
    
    // Configure your own styles and set them here.
    // e.g. ZenCopy.manager.styles.append("header", Style(color: nil, font: UIFont(named:"something", size:14)))
    //      ZenCopy.manager.styles.append("bindleGreen", Style(color: ..., font: nil)
    private var _styles = [String:Style]()
    public var styles: ((name: String) -> Style?)?
    
    public init() {
        
    }
    
    public func style(name: String) -> Style {
        if let style = _styles[name] {
            return style
        }
        return styles?(name: name) ?? Style() // TODO: default style?
    }
}