//
// Copyright © 2025 Sage.
// All Rights Reserved.


struct AppPlantItemsBuilder: PlantItemsBuilder {
    let subtitleBuilder: DisplaySubtitleBuilder
    let imageReader: ImagesStorageReaderService
    
    init(
        subtitleBuilder: DisplaySubtitleBuilder,
        imageReader: ImagesStorageReaderService = DocsImagesStorageService()
    ) {
        self.subtitleBuilder = subtitleBuilder
        self.imageReader = imageReader
    }
    
    func build(plants: [PlantStatus]) -> [DisplayItem] {
        return plants.map { plant -> DisplayItem in
                .init(
                    image: imageReader.getCell(plant: plant.plant),
                    title: plant.plant.name,
                    subtitle: subtitleBuilder.build(plant: plant),
                    separator: plant != plants.last,
                    disclosure: true,
                    type: .plant(plant.plant)
                )
        }
    }
    
}
