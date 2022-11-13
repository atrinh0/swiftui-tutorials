/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

@main
struct AnimatingShapesApp: App {
    @State var selection: Topic? = nil
    
    var body: some Scene {
        WindowGroup {
            NavigationSplitView {
                TopicList(contentSource: TopicData.homeContent)
            } detail: {
                Text("Please select a destination")
            }
        }
    }
}
