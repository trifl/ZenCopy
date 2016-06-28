import Foundation

public extension NSMutableAttributedString {
    // Add style
    public func addStyle(named styleName: String, regex: String) -> [NSTextCheckingResult]? {
        let style = Style()
        for styleName in ZenCopy.manager.styleNamesFromStyleString(styleName) {
            if let s = ZenCopy.manager.config.styles?(name: styleName) {
                style.append(s)
            }
        }
        return addStyle(style, regex: regex)
    }
    
    public func addStyle(style: Style, regex: String, tokenized: Bool = true) -> [NSTextCheckingResult]? {
        return self.style(style, regex: regex, tokenized: tokenized, replace: false)
    }
    
    public func setStyle(named styleName: String, regex: String, tokenized: Bool = true) -> [NSTextCheckingResult]? {
        let style = Style()
        for styleName in ZenCopy.manager.styleNamesFromStyleString(styleName) {
            if let s = ZenCopy.manager.config.styles?(name: styleName) {
                style.append(s)
            }
        }
        return self.setStyle(style, regex: regex, tokenized: tokenized)
    }
    
    public func setStyle(style: Style, regex: String, tokenized: Bool = true) -> [NSTextCheckingResult]? {
        return self.style(style, regex: regex, tokenized: tokenized, replace: true)
    }
    
    public func style(style: Style, regex: String, tokenized: Bool = true) -> [NSTextCheckingResult]? {
        return self.style(style, regex: regex, tokenized: tokenized, replace: true)
    }
    
    // Set (replace) style
    public func setStyle(named styleName: String, dataDetector: NSDataDetector, tokenized: Bool = true, replace: Bool = true) -> [NSTextCheckingResult]? {
        let matches = dataDetector.matchesInString(string, options: [], range: NSRange(location: 0, length: string.characters.count))
        let style = Style()
        for styleName in ZenCopy.manager.styleNamesFromStyleString(styleName) {
            if let s = ZenCopy.manager.config.styles?(name: styleName) {
                style.append(s)
            }
        }
        return self.style(style, matches: matches, tokenized: tokenized, replace: replace)
    }
    
    private func style(style: Style, matches: [NSTextCheckingResult], tokenized: Bool, replace: Bool) -> [NSTextCheckingResult]? {
        for match in matches {
            let range = (tokenized ? match.rangeAtIndex(match.numberOfRanges-1) : match.range)
            
            let attributes = ZenCopy.manager.attributesForStyle(style)
            if replace {
                self.setAttributes(attributes, range: range)
            } else if let attributes = attributes {
                self.addAttributes(attributes, range: range)
            }
        }
        
        return matches
    }
    
    // MARK: - Private
    private func style(style: Style, regex: String, tokenized: Bool, replace: Bool) -> [NSTextCheckingResult]? {
        do {
            let regularExpression = try NSRegularExpression(pattern: regex, options: NSRegularExpressionOptions(rawValue: 0))
            let range = NSRange(location: 0, length: self.length)
            
            let matches = regularExpression.matchesInString(self.string, options: NSMatchingOptions(rawValue: 0), range: range)
            
            return self.style(style, matches: matches, tokenized: tokenized, replace: replace)
        } catch _ {
            
        }
        return nil
    }
}