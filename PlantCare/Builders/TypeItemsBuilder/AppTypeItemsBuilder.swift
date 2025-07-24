//
// Copyright © 2025 Sage.
// All Rights Reserved.


struct AppTypeItemsBuilder: TypeItemsBuilder {
    init() {}
    
    func build(types: [PlantType]) -> [DisplayItem] {
        return types.map { type -> DisplayItem in
                .init(
                    image: nil,
                    title: type.name,
                    subtitle: .neutral("\(type.plants.count)"),
                    separator: type != types.last,
                    disclosure: false,
                    type: .plantType(type)
                )
        }
    }
    
}
