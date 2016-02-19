import Foundation

public struct Style {
    public var color: UIColor?
    public var font: UIFont?
    
    public init(color: UIColor? = nil, font: UIFont? = nil) {
        self.color = color
        self.font = font
    }
    
    public mutating func append(style: Style?) {
        guard let style = style else { return }
        if let color = style.color { self.color = color }
        if let font = style.font { self.font = font }
    }
}