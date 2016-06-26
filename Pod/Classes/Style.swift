import Foundation

public class Style: StringLiteralConvertible {
    public var color: UIColor?
    public var fontName: String?
    public var fontSize: CGFloat?
    public var underline: Bool?
    public var alpha: CGFloat?
    
    public required init(stringLiteral value: String) {
        for styleName in ZenCopy.manager.styleNames(fromStyleString: value) {
            if let style = styleName.style() {
                append(style)
            }
        }
    }
    
    public required init(extendedGraphemeClusterLiteral value: String) {
        for styleName in ZenCopy.manager.styleNames(fromStyleString: value) {
            if let style = styleName.style() {
                append(style)
            }
        }
    }
    
    public required init(unicodeScalarLiteral value: String) {
        for styleName in ZenCopy.manager.styleNames(fromStyleString: value) {
            if let style = styleName.style() {
                append(style)
            }
        }
    }
    
    public init(color: UIColor? = nil, fontName: String? = nil, fontSize: CGFloat? = nil, underline: Bool? = nil, alpha: CGFloat? = nil) {
        self.color = color
        self.fontName = fontName
        self.fontSize = fontSize
        self.underline = underline
        self.alpha = alpha
    }
    
    public func append(style: Style?) {
        guard let style = style else { return }
        if let color = style.color { self.color = color }
        if let fontName = style.fontName { self.fontName = fontName }
        if let fontSize = style.fontSize { self.fontSize = fontSize }
        if let alpha = style.alpha { self.alpha = alpha }
        if let underline = style.underline { self.underline = underline }
    }
}