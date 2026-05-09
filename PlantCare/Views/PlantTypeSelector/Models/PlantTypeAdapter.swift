import AtlasUI

struct PlantTypeAdapter: AtlasDefaultCellDataProtocol {
    var data: TrefleListResponse.Species
    
    init(data: TrefleListResponse.Species) {
        self.data = data
    }
    
    
    var image: AtlasCellImageType? {
        guard let imageUrl = data.imageUrl else { return nil }
        
        return .remote(imageUrl)
    }
    
    
    var title: String { data.scientificName }
    var subtitle: String { data.commonName ?? data.genus ?? "" }
    var caption: String? { data.family ?? data.familyCommonName }
    var chevron: Bool { true }
    var id: Int { data.id }
}
