/*
 See the License.txt file for this sample’s licensing information.
 */

import SwiftUI

struct StoryView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationView {
            StoryPageView(story: story, pageIndex: 0)
                .id(appState.rootViewId)
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView()
    }
}
