/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

class SmallDot : Identifiable, ObservableObject {
	let id = UUID()
    
	@Published var offset : CGSize = .zero
	@Published var color : Color = .primary
}

class BigDot : Identifiable, ObservableObject {
    let id = UUID()
    
    @Published var offset: CGSize = .zero
    @Published var color: Color = .primary
    @Published var scale: Double = 1.0
    @Published var smallDots = [SmallDot]()
    
    init() {
        for _ in 0..<5 {
            smallDots.append(SmallDot())
        }
    }
    
    func randomizePositions() {
        objectWillChange.send()
        for dot in smallDots {
            dot.offset = CGSize(width: Double.random(in: -120...120), height: Double.random(in: -120...120))
            dot.color = DotTracker.randomColor
        }
    }
 
    func resetPositions() {
        objectWillChange.send()
        for dot in smallDots {
            dot.offset = .zero
            dot.color = .primary
        }
    }

}

class DotTracker : ObservableObject {
    @Published var bigDots = [BigDot]()
    
    static var colors: [Color] = [.pink, .purple, .mint, .blue, .yellow, .red, .teal, .cyan]
    static var randomColor: Color {
        colors.randomElement() ?? .blue
    }
    
    init() {
        for _ in 0..<100 {
            bigDots.append(BigDot())
        }
    }
    
    func randomizePositions() {
        objectWillChange.send()
        for bigDot in bigDots {
            bigDot.offset = CGSize(width: Double.random(in: -50...50), height: Double.random(in: -50...50))
            bigDot.scale = 2.5
            bigDot.color = DotTracker.randomColor
            bigDot.randomizePositions()
        }
    }
    
    func resetPositions() {
        objectWillChange.send()
        for bigDot in bigDots {
            bigDot.offset = .zero
            bigDot.scale = 1.0
            bigDot.color = DotTracker.randomColor
            bigDot.resetPositions()
        }
    }

}

struct DancingDotsView: View {
    private var columns = Array(repeating: GridItem(.flexible()), count: 10)
    @StateObject var tracker = DotTracker()
    @State private var isAnimating = false

    var body: some View {
        VStack {
            Spacer()
            LazyVGrid(columns: columns) {
                ForEach(tracker.bigDots) { bigDot in
                    ZStack {
                        Circle()
                            .offset(bigDot.offset)
                            .foregroundColor(bigDot.color)
                            .scaleEffect(bigDot.scale)
                        ForEach(bigDot.smallDots) { smallDot in
                            Circle()
                                .offset(smallDot.offset)
                                .foregroundColor(smallDot.color)
                        }
                    }
                }
            }
            .frame(minHeight: 500)
            .drawingGroup()
            Spacer() 
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
