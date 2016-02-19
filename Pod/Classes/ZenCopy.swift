import Foundation

public class ZenCopy {
    public static let manager = Manager()
    public  class Manager {
        // ZenCopy will always check the languages in default order. If none pass, it will print the key.
        // It is a good idea to update this array such that the device locale is at index 0, and your default localse
        // is at the last index, though not necessary.
        public  var languages = ["en"]
        
        // [language:[key:value]] 
        // e.g. copy["en"]["profile.title"] = ["Hello world!"]
        // e.g. copy["en"]["profile.title"] = ["Hello ", "world!".style("token")]
        public var copy = [String:[String:[CopyComponent]]]()
        
        // Configure your own styles and set them here.
        // e.g. ZenCopy.manager.styles.append("header", Style(color: nil, font: UIFont(named:"something", size:14)))
        //      ZenCopy.manager.styles.append("bindleGreen", Style(color: ..., font: nil)
        public var styles = [String:Style]()
        
        // applying a style only updates the non-nil values. In the order the styles are applied.
        public init() {
            
        }
    }
}