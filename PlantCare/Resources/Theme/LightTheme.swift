import SwiftUI
import AtlasUI

struct LightTheme: AtlasPalette {
    var textOnActionPrimary: Color = .white
    

    // MARK: - Brand Actions (Primary Greens)
    let actionPrimary = Color(hex: "#006B27")
    let actionPrimaryStrong = Color(r: 45, g: 106, b: 79)    // #2D6A4F Emerald Deep
    let actionPrimarySoft = Color(r: 216, g: 243, b: 220)    // #D8F3DC Mint Soft

    // MARK: - Text Colors
    let textPrimary = Color(r: 26, g: 27, b: 31)
    let textSecondary = Color(r: 63, g: 74, b: 62)
    let textTertiary = Color(r: 111, g: 122, b: 109) // #6F7A6D

    // MARK: - Backgrounds
    let bgPrimary = Color(r: 250, g: 249, b: 254)
    let bgSecondary = Color(r: 244, g: 243, b: 248)
    let bgSurface = Color(r: 255, g: 255, b: 255)
    let bgSoftAccent = Color(r: 216, g: 243, b: 220)

    // MARK: - Functional / Care Actions
    let actionWater = Color(r: 30, g: 144, b: 255)          // #1E90FF Sky Blue
    let actionSoil = Color(r: 109, g: 76, b: 65)           // #6D4C41 Earth Brown
    let actionSun = Color(r: 255, g: 193, b: 7)            // #FFC107 Sun Glow
}
