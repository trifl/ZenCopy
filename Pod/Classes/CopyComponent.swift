public class CopyComponent: StringLiteralConvertible {
    public var value: String
    public var style: Style?
    
    public required init(stringLiteral value: String) {
        self.value = value
    }
    
    public required init(extendedGraphemeClusterLiteral value: String) {
        self.value = value
    }
    
    public required init(unicodeScalarLiteral value: String) {
        self.value = value
    }
    
    public init(value: String, style: Style? = nil) {
        self.value = value
        self.style = style
    }
    
}

public extension String {
    func style(styleName: String) -> CopyComponent {
        let style: Style? = nil
        // TODO: find style
        return self.style(style)
    }
    
    func style(style: Style?) -> CopyComponent {
        return CopyComponent(value: self, style: style)
    }
}