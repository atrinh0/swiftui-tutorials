/*
 See the License.txt file for this sample’s licensing information.
 */

import SwiftUI

struct DragNDropDotsView: View {
    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: 13)
    @State private var colors: [Color] = [.red, .orange, .yellow, .green, .blue, .indigo, .purple]
    @State private var offset = CGSize.zero
    @State private var isAnimating: Bool = false
    
    private let springAnimation = Animation.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.3)
    private let numCircles = 260
    private let animationSpeed: Double = 200
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                LazyVGrid(columns: gridColumns) {
                    ForEach((0..<numCircles), id: \.self) { index in
                        Circle()
                            .foregroundColor(colors[index % colors.count])
                            .offset(offset)
                            .animation(springAnimation.delay(Double(index) / animationSpeed), value: offset)
                    }
                }
                .gesture(DragGesture()
                    .onChanged { drag in
                        offset = drag.translation
                        isAnimating = true
                    })
                Spacer()
            }
            .navigationTitle("Drag n' Drop It")
            .navigationBarTitleDisplayMode(.inline)
            .clipShape(Rectangle())
            .safeAreaInset(edge: .top, spacing: 0) {
                Color.clear.frame(height: 0)
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                Color.clear.frame(height: 0)
            }
            PlayResetButton(animating: $isAnimating, resetOnly: true) {
                withAnimation(springAnimation) {
                    resetValues()
                }
            }
        }
    }
    
    private func resetValues() {
        offset = .zero
    }
}

struct DragNDropDotsView_Previews: PreviewProvider {
    static var previews: some View {
        DragNDropDotsView()
    }
}
