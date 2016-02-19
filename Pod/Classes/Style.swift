import Foundation

public struct Style {
    public var color: UIColor?
    public var font: UIFont?
    
    public init(color: UIColor? = nil, font: UIFont? = nil) {
        self.color = color
        self.font = font
    }
}