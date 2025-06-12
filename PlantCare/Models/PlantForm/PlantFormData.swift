//
//
// PlantCare
// Created by: tiago.pereira on 7/6/25
//

struct PlantFormData {
    var name: String
    
    init(plant: Plant?) {
        self.name = plant?.name ?? ""
    }
}
