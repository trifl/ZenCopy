public class CopyComponent: StringLiteralConvertible {
    public var value: String
    public var style: Style?
    public var name: String?
    
    public required init(stringLiteral value: String) {
        self.value = value
    }
    
    public required init(extendedGraphemeClusterLiteral value: String) {
        self.value = value
    }
    
    public required init(unicodeScalarLiteral value: String) {
        self.value = value
    }
    
    public init(value: String, style: Style? = nil, name: String? = nil) {
        self.value = value
        self.style = style
        self.name = name
    }
}

public extension String {
    func style(name: String) -> CopyComponent {
        return CopyComponent(value: self, name: name)
    }
    
    func style(style: Style?) -> CopyComponent {
        return CopyComponent(value: self, style: style)
    }
}