import Foundation

struct Category: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let description: String
    let icon: String
    let color: String
}

struct Shortcut: Identifiable, Codable, Hashable {
    let id: String
    let category: String
    let combo: String
    let title: String
    let description: String
}

struct ShortcutsData: Codable {
    let categories: [Category]
    let shortcuts: [Shortcut]
}

enum ShortcutsStore {
    static func load() -> ShortcutsData {
        let candidates = [
            Bundle.main.url(forResource: "shortcuts", withExtension: "json"),
            Bundle.main.url(forResource: "shortcuts", withExtension: "json", subdirectory: "Resources"),
        ].compactMap { $0 }

        guard let url = candidates.first,
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode(ShortcutsData.self, from: data) else {
            return ShortcutsData(categories: [], shortcuts: [])
        }
        return decoded
    }

    static func normalize(_ string: String) -> String {
        string
            .lowercased()
            .replacingOccurrences(of: "command", with: "⌘")
            .replacingOccurrences(of: "cmd", with: "⌘")
            .replacingOccurrences(of: "shift", with: "⇧")
            .replacingOccurrences(of: "option", with: "⌥")
            .replacingOccurrences(of: "opt", with: "⌥")
            .replacingOccurrences(of: "control", with: "⌃")
            .replacingOccurrences(of: "ctrl", with: "⌃")
            .replacingOccurrences(of: #"\s+"#, with: " ", options: .regularExpression)
            .trimmingCharacters(in: .whitespaces)
    }

    static func filtered(
        shortcuts: [Shortcut],
        categories: [Category],
        activeCategory: String,
        query: String
    ) -> [Shortcut] {
        let q = normalize(query)
        return shortcuts.filter { shortcut in
            let inCategory = activeCategory == "all" || shortcut.category == activeCategory
            guard inCategory else { return false }
            guard !q.isEmpty else { return true }
            let cat = categories.first { $0.id == shortcut.category }
            let haystack = normalize("\(shortcut.combo) \(shortcut.title) \(shortcut.description) \(cat?.title ?? "")")
            return haystack.contains(q)
        }
    }

    static func grouped(
        shortcuts: [Shortcut],
        categories: [Category]
    ) -> [(category: Category, items: [Shortcut])] {
        categories.compactMap { category in
            let items = shortcuts.filter { $0.category == category.id }
            guard !items.isEmpty else { return nil }
            return (category, items)
        }
    }

    static func count(for categoryId: String, in shortcuts: [Shortcut]) -> Int {
        categoryId == "all" ? shortcuts.count : shortcuts.filter { $0.category == categoryId }.count
    }
}
