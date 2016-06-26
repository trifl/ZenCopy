public class Regex {
    public class func findTokens(regex: String, text: String) -> [String]? {
        if let ranges = find(regex, text: text) {
            var results = [String]()
            for range in ranges {
                results.append((text as NSString).substringWithRange(range))
            }
            return results
        }
        return nil
    }
    
    // This method supports one capture group. If you use more than one, it will return the last range of each match.
    public class func find(regex: String, text: String) -> [NSRange]? {
        do {
            var ranges: [NSRange]?
            let regularExpression = try NSRegularExpression(pattern: regex, options: NSRegularExpressionOptions(rawValue: 0))
            let range = NSRange(location: 0, length: text.characters.count)
            let matches = regularExpression.matchesInString(text, options: NSMatchingOptions(rawValue: 0), range: range)
            
            if matches.count > 0 {
                ranges = [NSRange]()
                for match in matches {
                    ranges!.append(match.rangeAtIndex(match.numberOfRanges-1))
                }
                return ranges
            }
            return nil
        } catch {
            return nil
        }
    }
}