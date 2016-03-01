public extension NSMutableAttributedString {
    public func regexFind(regex: String, addStyle styleName: String, enumerate: ((match: NSTextCheckingResult) -> ())? = nil) {
        let style = Style()
        for styleName in ZenCopy.manager.styleNamesFromStyleString(styleName) {
            if let s = ZenCopy.manager.config.styles?(name: styleName) {
                style.append(s)
            }
        }
        regexFind(regex, addStyle: style, enumerate: enumerate)
    }
    
    public func regexFind(regex: String, addStyle style: Style, enumerate: ((match: NSTextCheckingResult) -> ())? = nil) {
        regexFind(regex, style: style, replace: false, enumerate: enumerate)
    }
    
    public func regexFind(regex: String, setStyle style: String, enumerate: ((match: NSTextCheckingResult) -> ())? = nil) {
        if let s = ZenCopy.manager.config.styles?(name: style) {
            regexFind(regex, setStyle: s, enumerate: enumerate)
        }
    }
    
    public func regexFind(regex: String, setStyle style: Style, enumerate: ((match: NSTextCheckingResult) -> ())? = nil) {
        regexFind(regex, style: style, replace: true, enumerate: enumerate)
    }
    
    private func regexFind(regex: String, style: Style, replace: Bool, enumerate: ((match: NSTextCheckingResult) -> ())? = nil) {
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
                enumerate?(match: match)
            }
        } catch _ {
            
        }
    }
}
