//
//
// PlantCare
// Created by: tiago.pereira on 4/6/25
//

protocol DashboardSectionProtocol: Hashable {
    associatedtype Item = DashboardSectionItemProtocol
    
    var type: DashboardSectionType { get }
    var title: String { get }
    var actionString: String { get }
    
    var items: [Item] { get }
}
