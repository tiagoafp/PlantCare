//
// Copyright © 2026 Sage.
// All Rights Reserved.

import Foundation

struct Plant: Codable, Hashable {
    let name: String
    let image: String
    let type: PlantType
    let createdAt: Date
}
