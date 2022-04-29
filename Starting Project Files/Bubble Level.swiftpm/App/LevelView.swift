/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct LevelView: View {
    @EnvironmentObject var motionDetector: MotionDetector

    var body: some View {
        VStack {
            BubbleLevel()
            OrientationDataView()
                .padding(.top, 80)
        }
        .onAppear {
            motionDetector.start()
        }
        .onDisappear {
            motionDetector.stop()
        }
    }
}

struct LevelView_Previews: PreviewProvider {
    @StateObject static var motionDetector = MotionDetector(updateInterval: 0.01).started()
    
    static var previews: some View {
        LevelView()
            .environmentObject(motionDetector)
    }
}
                                         
