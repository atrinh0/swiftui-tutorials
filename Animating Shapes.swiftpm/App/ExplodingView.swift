/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct ExplodingView: View {
    @State private var isExploded = false
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                ForEach(0..<15) { row in
                    ForEach(0..<15) { col in
                        Rectangle()
                            .rotation(Angle(degrees: isExploded ? Double.random(in: 0..<360) : 0))
                            .frame(width: 20, height: 20)
                            .foregroundColor(.indigo)
                            .scaleEffect(isExploded ? Double.random(in: 1...2) : 1)
                            .offset(x: isExploded ? randomDistance : CGFloat(150 - col * 20),
                                    y: isExploded ? randomDistance : CGFloat(150 - row * 20))
                            .opacity(isExploded ? 0 : 1)
                            .animation(isExploded ? .easeOut.speed(Double.random(in: 0.6...1)) : .spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.3),
                                       value: isExploded)
                            .padding()
                    }
                }
            }
            Spacer()
            PlayResetButton(animating: $isExploded)
        }
        .navigationTitle("Explosion Animation")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var randomDistance: CGFloat {
        (Double.random(in: -1...1) * 500)
    }
}

struct ExplodingView_Previews: PreviewProvider {
    static var previews: some View {
        ExplodingView()
    }
}

