/*
 See the License.txt file for this sample’s licensing information.
 */

import SwiftUI

struct RollinRainbowView: View {
    @State private var isAnimating = false
    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: 13)
    @State private var colors: [Color] = [.red, .orange, .yellow, .green, .blue, .indigo, .purple]
    @State private var scaleFactor: CGFloat = 3
    
    let springAnimation = Animation.spring(response: 0.3, dampingFraction: 0.1, blendDuration: 0.3)
    let numCircles = 260

    var body: some View {
        VStack {
            Text("Tap on the dots to make them roll!")
                .padding(.vertical, 30)
            Spacer()
            LazyVGrid(columns: gridColumns) {
                ForEach(0..<numCircles, id: \.self) { index in
                    Circle()
                        .foregroundColor(colors[index % colors.count])
                        .scaleEffect(scaleFactor)
                        .animation(springAnimation.delay((Double(index).truncatingRemainder(dividingBy: Double(colors.count)) / 20)),
                                   value: scaleFactor)
                        .onTapGesture {
                            isAnimating = true
                            scaleFactor = (Double((index % 13) + 1) / 4)
                        }
                }
            }
            .padding()
            Spacer()
            PlayResetButton(animating: $isAnimating, resetOnly: true) {
                scaleFactor = 3
            }
        }
        .navigationTitle("Rollin' Rainbow")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct Pulse_Previews: PreviewProvider {
    static var previews: some View {
        RollinRainbowView()
    }
}
