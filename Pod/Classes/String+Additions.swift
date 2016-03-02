import Foundation

public extension String {
    func style() -> Style? {
        return manager.config.styles?(name: self)
    }
}