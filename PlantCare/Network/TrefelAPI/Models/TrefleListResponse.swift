
struct TrefleListResponse: Codable, Sendable, Hashable {
    let data: [Species]
    let links: PaginationLinks
    let meta: Meta
}

extension TrefleListResponse {
    // MARK: - Species
    struct Species: Codable, Sendable, Hashable {
        let id: Int
        let commonName: String?
        let slug: String?
        let scientificName: String
        let year: Int?
        let bibliography: String?
        let author: String?
        let status: String?
        let rank: String?
        let familyCommonName: String?
        let genusID: Int?
        let imageUrl: String?
        let synonyms: [String]
        let genus: String?
        let family: String?
        let links: SpeciesLinks
    }
    
    // MARK: - Links inside each species
    struct SpeciesLinks: Codable, Sendable, Hashable {
        let genus: String?
        let plant: String?
        let `self`: String?
    }
    
    // MARK: - Pagination links
    struct PaginationLinks: Codable, Sendable, Hashable {
        let first: String?
        let last: String?
        let next: String?
        let `self`: String?
    }
    
    // MARK: - Meta
    struct Meta: Codable, Sendable, Hashable {
        let total: Int
    }
}
