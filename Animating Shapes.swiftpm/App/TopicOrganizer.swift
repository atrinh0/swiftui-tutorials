/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

enum Destination: String, CaseIterable {
    case basicShapes
    case simpleAnimation
    case spinningAnimation
    case explodingAnimation
    case rollingRainbow
    case dragnDropDots
    case dancingDots

    
    @ViewBuilder
    static func view(forSelection selection: Destination) -> some View {
        switch selection {
        case .basicShapes:
            BasicShapesView()
        case .simpleAnimation:
            HeartPulseView()
        case .spinningAnimation:
           SpinningView()
        case .explodingAnimation:
           ExplodingView()
        case .rollingRainbow:
            RollinRainbowView()
        case .dragnDropDots:
            DragNDropDotsView()
        case .dancingDots:
            DancingDotsView()
        }
    }
}

struct TopicData {
    static var homeContent = [
        Topic(
            title: "Basic Shapes",
            description: "Experiment with different shape types.",
            systemSymbol: "square.on.circle",
            destination: .basicShapes
        ),
		Topic(
			title: "Basic Animation",
			description: "See an example of a basic animation.",
			systemSymbol: "heart",
			destination: .simpleAnimation
		),
        Topic(
            title: "Spinning Animation",
            description: "View a basic shape spinning on its x axis.",
            systemSymbol: "arrow.left.arrow.right.circle",
            destination: .spinningAnimation
        ),
        Topic(
            title: "Explosion Animation",
            description: "Tap to explode a rectangle into many pieces.",
            systemSymbol: "sparkles",
            destination: .explodingAnimation
        ),
        
        Topic(
            title: "Rollin' Rainbow",
            description: "Explore an animation that makes a wave.",
            systemSymbol: "wind",
            destination: .rollingRainbow
        ),
        Topic(
            title: "Drag N' Drop It",
            description: "Use a drag gesture to move and animate a grid view.",
            systemSymbol: "hand.draw",
            destination: .dragnDropDots
        ),
        Topic(
            title: "Dancing Dots",
            description: "Explore an advanced animation that really pops.",
            systemSymbol: "circle.grid.3x3",
            destination: .dancingDots
        )
    ]
}
