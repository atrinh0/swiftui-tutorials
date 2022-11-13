/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI


struct TopicList: View {
    
    var contentSource: [Topic]
    
    var body: some View {
        Section {
            List {
                ForEach(contentSource) { row in
                    NavigationLink(
                        destination: Destination.view(forSelection: row.destination), label: {
                            TopicRowView(title: row.title, description: row.description, systemIcon: row.systemSymbol)
                        })
                        .fixedSize(horizontal: false, vertical: true)
                        .listRowInsets(.init(top: 15, leading: 15, bottom: 15, trailing: 15))
                    
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Animating Shapes")
            
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            Color.clear.frame(height: 15)
        }
    }
    
}

struct TopicList_Previews: PreviewProvider {
    static var previews: some View {
        TopicList(contentSource: TopicData.homeContent)
    }
}
