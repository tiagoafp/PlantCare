//
// Copyright © 2025 Sage.
// All Rights Reserved.

import Mockable

@Mockable
protocol DashboardItemsBuilder {
    func buildWater(plants: [Plant]) -> [DashboardItem]
    func buildPlants(plants: [Plant]) -> [DashboardItem]
    func buildTypes(types: [PlantType]) -> [DashboardItem]
}


struct StaticDashboardItemBuilder: DashboardItemsBuilder {
    func buildWater(plants: [Plant]) -> [DashboardItem] {
        return [
            .init(
                image: "",
                title: "PlantA",
                subtitle: .negative(.plural(.missing_water(15)))
            ),
            .init(
                image: "",
                title: "PlantB",
                subtitle: .negative(.plural(.missing_water(20)))
            ),
            .init(
                image: "",
                title: "PlantC",
                subtitle: .negative(.plural(.missing_water(89))),
                separator: false
            )
        ]
    }
    
    func buildPlants(plants: [Plant]) -> [DashboardItem] {
        return [
            .init(
                image: "",
                title: "PlantA",
                subtitle: .negative(.localized(.missing_water))
            ),
            .init(
                image: "",
                title: "PlantB",
                subtitle: .warning(.localized(.irregular_water))
            ),
            .init(
                image: "",
                title: "PlantC",
                subtitle: .positive(.localized(.all_good)),
                separator: false
            )
        ]
    }
    
    func buildTypes(types: [PlantType]) -> [DashboardItem] {
        return [
            .init(
                image: nil,
                title: "TypeA",
                subtitle: .neutral(.plural(.number_of_plants(10))),
                disclosure: false
            ),
            .init(
                image: nil,
                title: "TypeB",
                subtitle: .neutral(.plural(.number_of_plants(9))),
                disclosure: false
            ),
            .init(
                image: nil,
                title: "TypeC",
                subtitle: .neutral(.plural(.number_of_plants(8))),
                separator: false,
                disclosure: false
            )
        ]
    }
}
