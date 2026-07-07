import Foundation
import Combine

@MainActor
final class ScholarwatchStore: ObservableObject {
    @Published private(set) var items: [ScholarwatchItem] = []
    @Published var isPro: Bool = false

    /// Free-tier cap. Deliberately set well above the seed-data count so a fresh
    /// install never trips the paywall immediately.
    static let freeLimit = 20

    private let fileURL: URL

    init() {
        let support = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        try? FileManager.default.createDirectory(at: support, withIntermediateDirectories: true)
        fileURL = support.appendingPathComponent("scholarwatch_items.json")
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Self.freeLimit
    }

    func add(title: String, category: String, value: Double, notes: String = "") -> Bool {
        guard canAddMore else { return false }
        let item = ScholarwatchItem(title: title, category: category, value: value, notes: notes)
        items.insert(item, at: 0)
        save()
        return true
    }

    func update(_ item: ScholarwatchItem) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: ScholarwatchItem) {
        items.removeAll { $0.id == item.id }
        save()
    }

    func toggleResolved(_ item: ScholarwatchItem) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx].isResolved.toggle()
        save()
    }

    var totalValue: Double {
        items.reduce(0) { $0 + $1.value }
    }

    func total(for category: String) -> Double {
        items.filter { $0.category == category }.reduce(0) { $0 + $1.value }
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([ScholarwatchItem].self, from: data) else {
            items = Self.seedData()
            save()
            return
        }
        items = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    static func seedData() -> [ScholarwatchItem] {
        [
        ScholarwatchItem(title: "STEM Merit Award", category: "Merit", value: 0.0),
        ScholarwatchItem(title: "Regional Grant", category: "Need-Based", value: 0.0)
        ]
    }
}
