import SwiftUI
import AtlasUI

struct DarkTheme: AtlasPalette {

    // MARK: - Brand
    let actionPrimary = Color(r: 56, g: 189, b: 102)
    let actionPrimaryStrong = Color(r: 45, g: 106, b: 79)
    let actionPrimarySoft = Color(r: 20, g: 60, b: 40)

    // MARK: - Text
    let textPrimary = Color(r: 241, g: 245, b: 249)
    let textSecondary = Color(r: 148, g: 163, b: 184)
    let textOnActionPrimary = Color.white

    // MARK: - Backgrounds
    let bgPrimary = Color(r: 15, g: 23, b: 42)
    let bgSurface = Color(r: 30, g: 41, b: 59)
    let bgSoftAccent = Color(r: 20, g: 60, b: 40)
    
    // MARK: - Functional / Care Actions
    let actionWater = Color(r: 30, g: 144, b: 255)          // #1E90FF Sky Blue
    let actionSoil = Color(r: 109, g: 76, b: 65)           // #6D4C41 Earth Brown
    let actionSun = Color(r: 255, g: 193, b: 7)            // #FFC107 Sun Glow
}
