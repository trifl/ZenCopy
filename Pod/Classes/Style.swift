import Foundation

public struct Style {
    public var color: UIColor?
    public var font: UIFont?
    public var name: String?
    
    public init(color: UIColor? = nil, font: UIFont? = nil, name: String? = nil) {
        self.color = color
        self.font = font
        self.name = name
    }
}