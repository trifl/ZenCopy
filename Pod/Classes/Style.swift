import Foundation

public struct Style {
    public var color: UIColor?
    public var fontName: String?
    public var fontSize: CGFloat?
    
    public init(color: UIColor? = nil, fontName: String? = nil, fontSize: CGFloat? = nil) {
        self.color = color
        self.fontName = fontName
        self.fontSize = fontSize
    }
    
    public mutating func append(style: Style?) {
        guard let style = style else { return }
        if let color = style.color { self.color = color }
        if let fontName = style.fontName { self.fontName = fontName }
        if let fontSize = style.fontSize { self.fontSize = fontSize }
    }
}