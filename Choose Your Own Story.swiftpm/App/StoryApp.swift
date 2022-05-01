/*
 See the License.txt file for this sample’s licensing information.
 */

import SwiftUI

@main
struct StoryApp: App {
    @ObservedObject var appState = AppState()

    var body: some Scene {
        WindowGroup {
            StoryView()
                .environmentObject(appState)
        }
    }
}

final class AppState: ObservableObject {
    @Published var rootViewId = UUID()
}
