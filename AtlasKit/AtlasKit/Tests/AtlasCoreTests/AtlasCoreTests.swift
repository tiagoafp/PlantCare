import Testing
@testable import AtlasCore

@Test func atlasCoreModuleName() async throws {
    #expect(AtlasCore.moduleName == "AtlasCore")
}
