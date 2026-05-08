import Testing
@testable import AtlasNetwork

@Test func atlasNetworkModuleName() async throws {
    #expect(AtlasNetwork.moduleName == "AtlasNetwork")
    #expect(AtlasNetwork.coreModuleName == "AtlasCore")
}
