/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

@main
struct MemeCreatorApp: App {
    @StateObject private var fetcher: PandaCollectionFetcher

    init() {
        self._fetcher = StateObject(wrappedValue: PandaCollectionFetcher())
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MemeCreator()
                    .environmentObject(fetcher)
            }
            .navigationViewStyle(.stack)
        }
    }
}