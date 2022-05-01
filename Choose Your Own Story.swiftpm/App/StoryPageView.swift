/*
 See the License.txt file for this sample’s licensing information.
 */

import SwiftUI

struct StoryPageView: View {
    @EnvironmentObject var appState: AppState
    
    let story: Story
    let pageIndex: Int
    
    var body: some View {
        VStack {
            ScrollView {
                Text(story[pageIndex].text)
            }
            ForEach(story[pageIndex].choices, id: \.text) { choice in
                NavigationLink(destination: StoryPageView(story: story, pageIndex: choice.destination)) {
                    Text(choice.text)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    //                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(buttonColorWithHints(destination: choice.destination))
                        .cornerRadius(15)
                }
            }
            if story[pageIndex].choices.isEmpty {
                Button("Restart") {
                    appState.rootViewId = UUID()
                }
                .padding()
            }
        }
        .padding(.horizontal)
        .navigationTitle("Page \(pageIndex + 1)")
        .navigationBarTitleDisplayMode(.large)
    }

    private func buttonColorWithHints(destination: Int) -> Color {
        if isWinner(destination: destination) {
            return .green
        }

        return isDeadEnd(destination: destination) ? Color.red : Color.blue
    }

    private func isDeadEnd(destination: Int) -> Bool {
        story[destination].choices.isEmpty
    }

    private func isWinner(destination: Int) -> Bool {
        [15, 17, 19].contains(destination)
    }
}

struct NonlinearStory_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StoryPageView(story: story, pageIndex: 0)
        }
    }
}
