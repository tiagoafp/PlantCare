import SwiftUI

public protocol AtlasTimelineCellDataProtocol: Hashable, Identifiable {
    var id: ObjectIdentifier { get }
    var timelineIcon: Image? { get }
    var relatedColor: Color? { get }
    var title: String { get }
    var date: String { get }
    var descripction: String? { get }
    var photo: UIImage? { get }
}

