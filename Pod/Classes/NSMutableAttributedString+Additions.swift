public extension NSMutableAttributedString {
    func regexFind(regex: String, setStyle style: Style) {
        do {
            let regularExpression = try NSRegularExpression(pattern: regex, options: NSRegularExpressionOptions(rawValue: 0))
            let range = NSRange(location: 0, length: self.length)
            
            let matches = regularExpression.matchesInString(self.string, options: NSMatchingOptions(rawValue: 0), range: range)
            for match in matches {
                let range = match.range
                
                let attributes = ZenCopy.manager.attributesForStyle(style)
                self.setAttributes(attributes, range: range)
            }
        } catch _ {
            
        }
    }
}
