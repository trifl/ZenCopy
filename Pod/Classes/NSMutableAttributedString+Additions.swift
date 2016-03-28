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
    
    public func addStyle(style: Style, regex: String) -> [NSTextCheckingResult]? {
        return self.style(style, regex: regex, replace: false)
    }
    
    // Set (replace) style
    public func setStyle(named styleName: String, regex: String) -> [NSTextCheckingResult]? {
        let style = Style()
        for styleName in ZenCopy.manager.styleNamesFromStyleString(styleName) {
            if let s = ZenCopy.manager.config.styles?(name: styleName) {
                style.append(s)
            }
        }
        return nil
    }
    
    public func setStyle(style: Style, regex: String) -> [NSTextCheckingResult]? {
        return self.style(style, regex: regex, replace: true)
    }
    
    // MARK: - Private
    private func style(style: Style, regex: String, replace: Bool) -> [NSTextCheckingResult]? {
        do {
            let regularExpression = try NSRegularExpression(pattern: regex, options: NSRegularExpressionOptions(rawValue: 0))
            let range = NSRange(location: 0, length: self.length)
            
            let matches = regularExpression.matchesInString(self.string, options: NSMatchingOptions(rawValue: 0), range: range)
            for match in matches {
                let range = match.range
                
                let attributes = ZenCopy.manager.attributesForStyle(style)
                if replace {
                    self.setAttributes(attributes, range: range)
                } else if let attributes = attributes {
                    self.addAttributes(attributes, range: range)
                }
            }
            return matches
        } catch _ {
            
        }
        return nil
    }
}
