import Foundation

struct ScholarwatchItem: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var title: String
    var category: String
    var value: Double
    var date: Date = Date()
    var notes: String = ""
    var isResolved: Bool = false
}

enum ScholarwatchCategory: String, CaseIterable, Codable {
        case merit = "Merit"
    case needbased = "Need-Based"
    case departmental = "Departmental"
    case renewable = "Renewable"
}
