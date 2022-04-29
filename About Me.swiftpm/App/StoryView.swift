/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct StoryView: View {
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    Text(information.story)
                        .font(.body)
                        .padding(.horizontal)
                        .padding(.vertical, 50)
                }
            }
            .navigationTitle("My Story")
        }
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView()
    }
}
