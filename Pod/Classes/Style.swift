import Foundation

public class Style: StringLiteralConvertible {
    public var color: UIColor?
    public var fontName: String?
    public var fontSize: CGFloat?
    
    
    public required init(stringLiteral value: String) {
        for styleName in ZenCopy.manager.styleNamesFromStyleString(value) {
            if let style = ZenCopy.manager.config.styles?(name: styleName) {
                append(style)
            }
        }
    }
    
    public required init(extendedGraphemeClusterLiteral value: String) {
        for styleName in ZenCopy.manager.styleNamesFromStyleString(value) {
            if let style = ZenCopy.manager.config.styles?(name: styleName) {
                append(style)
            }
        }
    }
    
    public required init(unicodeScalarLiteral value: String) {
        for styleName in ZenCopy.manager.styleNamesFromStyleString(value) {
            if let style = ZenCopy.manager.config.styles?(name: styleName) {
                append(style)
            }
        }
    }
    
    public init(color: UIColor? = nil, fontName: String? = nil, fontSize: CGFloat? = nil) {
        self.color = color
        self.fontName = fontName
        self.fontSize = fontSize
    }
    
    public func append(style: Style?) {
        guard let style = style else { return }
        if let color = style.color { self.color = color }
        if let fontName = style.fontName { self.fontName = fontName }
        if let fontSize = style.fontSize { self.fontSize = fontSize }
    }
}