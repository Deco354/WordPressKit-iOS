
import Foundation

public extension FormattableContentKind {
    public static let text = FormattableContentKind("text")
}

open class FormattableTextContent: FormattableContent {
    open var kind: FormattableContentKind {
        return .text
    }

    open var text: String? {
        return internalText
    }

    public let ranges: [FormattableContentRange]
    public var parent: FormattableContentParent?
    public var actions: [FormattableContentAction]?
    public var meta: [String : AnyObject]?

    private let internalText: String?

    public required init(dictionary: [String : AnyObject], actions commandActions: [FormattableContentAction], parent note: FormattableContentParent) {
        let rawRanges   = dictionary[Constants.BlockKeys.Ranges] as? [[String: AnyObject]]

        actions = commandActions
        ranges = FormattableTextContent.rangesFrom(rawRanges)
        parent = note
        internalText = dictionary[Constants.BlockKeys.Text] as? String
        meta = dictionary[Constants.BlockKeys.Meta] as? [String: AnyObject]
    }

    public init(text: String, ranges: [NotificationContentRange]) {
        self.internalText = text
        self.ranges = ranges
    }

    private static func rangesFrom(_ rawRanges: [[String: AnyObject]]?) -> [NotificationContentRange] {
        let parsed = rawRanges?.compactMap(NotificationContentRangeFactory.contentRange)
        return parsed ?? []
    }
}

public extension FormattableMediaItem {
    fileprivate enum MediaKeys {
        static let RawType      = "type"
        static let URL          = "url"
        static let Indices      = "indices"
        static let Width        = "width"
        static let Height       = "height"
    }
}

private enum Constants {
    fileprivate enum BlockKeys {
        static let Meta         = "meta"
        static let Ranges       = "ranges"
        static let Text         = "text"
    }
}
