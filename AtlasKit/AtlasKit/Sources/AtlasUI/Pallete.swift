import SwiftUI

@available(iOS 18.0, macOS 10.15, *)
public protocol AtlasPalette: Sendable {
    var actionPrimary: Color { get }
    var actionPrimaryStrong: Color { get }
    var actionPrimarySoft: Color { get }
    var textPrimary: Color { get }
    var textSecondary: Color { get }
    var textTertiary: Color { get }
    var textOnActionPrimary: Color { get }
    var bgPrimary: Color { get }
    var bgSecondary: Color { get }
    var bgSurface: Color { get }
    var bgSoftAccent: Color { get }
}
