import Testing
@testable import AtlasUI

@Test func atlasUIModuleName() async throws {
    #expect(AtlasUI.moduleName == "AtlasUI")
    #expect(AtlasUI.coreModuleName == "AtlasCore")
}

@Test func atlasUIStringsTapToUpload() async throws {
    #expect(AtlasUI.Strings.tapToUpload.format == "Tap to upload")
}
