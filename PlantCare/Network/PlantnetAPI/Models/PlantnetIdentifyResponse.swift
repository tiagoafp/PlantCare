import Foundation

struct PlantnetIdentifyResponse: Codable, Sendable {
    let query: Query
    let predictedOrgans: [PredictedOrgan]
    let language: String
    let preferedReferential: String
    let bestMatch: String
    let results: [ResultItem]
    let version: String
    let remainingIdentificationRequests: Int
}

extension PlantnetIdentifyResponse {
    // MARK: - Query
    struct Query: Codable, Sendable {
        let project: String
        let images: [String]
        let organs: [String]
        let includeRelatedImages: Bool
        let noReject: Bool
        let type: String?
    }
    
    // MARK: - Predicted Organs
    struct PredictedOrgan: Codable, Sendable {
        let image: String
        let filename: String
        let organ: String
        let score: Double
    }
    
    // MARK: - Results
    struct ResultItem: Codable, Sendable {
        let score: Double
        let species: Species
        let gbif: ExternalID?
        let powo: ExternalID?
    }
    
    // MARK: - Species
    struct Species: Codable, Sendable {
        let scientificNameWithoutAuthor: String
        let scientificNameAuthorship: String
        let genus: Taxonomy
        let family: Taxonomy
        let commonNames: [String]
        let scientificName: String
    }
    
    // MARK: - Taxonomy (Genus / Family)
    struct Taxonomy: Codable, Sendable {
        let scientificNameWithoutAuthor: String
        let scientificNameAuthorship: String
        let scientificName: String
    }
    
    // MARK: - External IDs (GBIF / POWO)
    struct ExternalID: Codable, Sendable {
        let id: String
    }
}
