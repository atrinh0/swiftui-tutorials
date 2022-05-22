/*
See the License.txt file for this sample’s licensing information.
*/

import Foundation
import SwiftUI

class DataModel: ObservableObject {
    @Published var items: [Item] = []
    
    init() {
        var urls: [URL] = []
        if let documentDirectory = FileManager.default.documentDirectory {
            urls.append(contentsOf: FileManager.default.getContentsOfDirectory(documentDirectory).filter { $0.isImage })
        }
        urls.append(contentsOf: Bundle.main.urls(forResourcesWithExtension: "jpg", subdirectory: nil) ?? [])
        urls.forEach { items.append(Item(url: $0)) }
    }

    func add(url: URL) {
        if let savedUrl = FileManager.default.copyItemToDocumentDirectory(from: url) {
            // Add the new item to the data model.
            let item = Item(url: savedUrl)
            Task { @MainActor in
                withAnimation {
                    addItem(item)
                }
            }
        }
    }

    func removeItem(_ item: Item) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
            FileManager.default.removeItemFromDocumentDirectory(url: item.url)
        }
    }

    private func addItem(_ item: Item) {
        items.insert(item, at: 0)
    }
}

extension URL {
    /// Indicates whether the URL has a file extension corresponding to a common image format.
    var isImage: Bool {
        ["jpg", "jpeg", "png", "gif", "heic"].contains(self.pathExtension)
    }
}

