public protocol FormattableContentActionCommand: CustomStringConvertible {
    var identifier: Identifier { get }
    var icon: UIButton? { get }

    func execute(context: ActionContext)
}

extension FormattableContentActionCommand {
    public static func commandIdentifier() -> Identifier {
        return Identifier(value: String(describing: self))
    }
}

extension FormattableContentActionCommand {
    public var description: String {
        return identifier.description
    }
}
