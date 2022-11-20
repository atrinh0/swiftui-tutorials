/*
 See the License.txt file for this sample’s licensing information.
 */

import SwiftUI

class SmallDot: Identifiable, ObservableObject {
    let id = UUID()
    @Published var offset: CGSize = .zero
    @Published var color: Color = .primary
    @Published var scale: Double = 1
    @Published var opacity: Double = 1
}

class BigDot: Identifiable, ObservableObject {
    let id = UUID()
    @Published var smallDots = [SmallDot]()
    
    init() {
        for _ in 0..<25 {
            smallDots.append(SmallDot())
        }
    }
    
    func randomizePositions() {
        objectWillChange.send()
        for dot in smallDots {
            dot.offset = CGSize(width: Double.random(in: -220...220),
                                height: Double.random(in: -220...220))
            dot.color = DotTracker.randomColor
            dot.scale = Double.random(in: 0.5...5.0)
            dot.opacity = Double.random(in: 0.1...1.0)
        }
    }

    func resetPositions() {
        objectWillChange.send()
        for dot in smallDots {
            dot.offset = .zero
            dot.color = .primary
            dot.scale = 1
            dot.opacity = 1
        }
    }

}

class DotTracker: ObservableObject {
    @Published var bigDots = [BigDot]()
    
    private static var colors: [Color] = [.red, .orange, .yellow, .green, .blue, .indigo, .purple]
    static var randomColor: Color {
        colors.randomElement() ?? .blue
    }
    
    init() {
        for _ in 0..<9 {
            bigDots.append(BigDot())
        }
    }
    
    func randomizePositions() {
        objectWillChange.send()
        for bigDot in bigDots {
            bigDot.randomizePositions()
        }
    }
    
    func resetPositions() {
        objectWillChange.send()
        for bigDot in bigDots {
            bigDot.resetPositions()
        }
    }

}

struct DancingDotsView: View {
    private var columns = Array(repeating: GridItem(.fixed(10)), count: 3)
    @StateObject private var tracker = DotTracker()
    @State private var isAnimating = false

    var body: some View {
        VStack {
            GeometryReader { geo in
                LazyVGrid(columns: columns) {
                    ForEach(tracker.bigDots) { bigDot in
                        ZStack {
                            ForEach(bigDot.smallDots) { smallDot in
                                Circle()
                                    .offset(smallDot.offset)
                                    .foregroundColor(smallDot.color)
                                    .scaleEffect(smallDot.scale)
                                    .opacity(smallDot.opacity)
                            }
                        }
                    }
                }
                .frame(minHeight: geo.size.height)
            }
            .drawingGroup()
            PlayResetButton(animating: $isAnimating) {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.5, blendDuration: 1).repeatForever()) {
                    if isAnimating {
                        tracker.randomizePositions()
                    } else {
                        tracker.resetPositions()
                    }
                }
            }
        }
        .navigationTitle("Dancing Dots")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DancingDotsView_Previews: PreviewProvider {
    static var previews: some View {
        DancingDotsView()
    }
}
