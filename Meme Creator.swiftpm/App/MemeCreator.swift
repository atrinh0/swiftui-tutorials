/*
 See the License.txt file for this sample’s licensing information.
 */

import SwiftUI

struct MemeCreator: View {
    @EnvironmentObject var fetcher: PandaCollectionFetcher
    
    @State private var memeText = ""
    @State private var textSize = 60.0
    @State private var textColor = Color.white
    @State private var isPickingPanda = false

    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            LoadableImage(imageMetadata: fetcher.currentPanda)
                .overlay(alignment: .bottom) {
                    TextField("Meme Text", text: $memeText, prompt: Text(""))
                        .focused($isFocused)
                        .font(.system(size: textSize, weight: .heavy))
                        .shadow(radius: 10)
                        .foregroundColor(textColor)
                        .multilineTextAlignment(.center)
                        .padding()
                }

            Spacer()
            
            if isFocused {
                HStack {
                    Spacer()
                    Slider(value: $textSize, in: 20...140)
                    ColorPicker("Color", selection: $textColor)
                        .labelsHidden()
                    Spacer()
                }
                .padding(.vertical)
                .frame(maxWidth: 325)
            }
        }
        .padding()
        .task {
            try? await fetcher.fetchData()
        }
        .navigationTitle("Meme Creator")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    isPickingPanda = true
                } label: {
                    Image(systemName: "photo.fill.on.rectangle.fill")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isFocused = true
                } label: {
                    Image(systemName: "textformat")
                }
            }
        }
        .popover(isPresented: $isPickingPanda) {
            PandaPicker()
        }
    }
}
