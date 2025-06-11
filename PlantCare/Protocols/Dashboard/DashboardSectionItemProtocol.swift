//
//
// PlantCare
// Created by: tiago.pereira on 4/6/25
//
import PixelKit
import SwiftData

protocol DashboardSectionItemProtocol: Hashable {
    var image: ImageView.Variant? { get }
    @MainActor
    var subtitle: String { get }
    var subtitleType: CellSubtitle.Variant { get }
    var name: String { get }
    var disclosure: Bool { get }
}
