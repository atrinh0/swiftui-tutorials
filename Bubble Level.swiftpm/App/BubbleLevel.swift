/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct BubbleLevel: View {
    @EnvironmentObject var detector: MotionDetector

    private let range = Double.pi
    private let levelSize: CGFloat = 300
    private let bubbleSize: CGFloat = 200

    private func bubbleXPosition(_ isFirst: Bool) -> CGFloat {
        let zeroBasedRoll = (detector.roll * (isFirst ? 1 : -1)) + range / 2
        let rollAsFraction = zeroBasedRoll / range
        return rollAsFraction * levelSize
    }

    private func bubbleYPosition(_ isFirst: Bool) -> CGFloat {
        let zeroBasedPitch = (detector.pitch * (isFirst ? 1 : -1)) + range / 2
        let pitchAsFraction = zeroBasedPitch / range
        return pitchAsFraction * levelSize
    }

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color(red: 254/255, green: 44/255, blue: 85/255, opacity: 1))
                .frame(width: bubbleSize, height: bubbleSize)
                .position(x: bubbleXPosition(true),
                          y: bubbleYPosition(true))
                .blendMode(.plusLighter)
            Circle()
                .foregroundColor(Color(red: 37/255, green: 244/255, blue: 238/255, opacity: 1))
                .frame(width: bubbleSize, height: bubbleSize)
                .position(x: bubbleXPosition(false),
                          y: bubbleYPosition(false))
                .blendMode(.plusLighter)
        }
        .frame(width: levelSize, height: levelSize)
    }
}

struct BubbleLevel_Previews: PreviewProvider {
    @StateObject static var motionDetector = MotionDetector(updateInterval: 0.01).started()

    static var previews: some View {
        BubbleLevel()
            .environmentObject(motionDetector)
    }
}
