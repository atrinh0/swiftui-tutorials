/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct LevelView: View {
    @EnvironmentObject var motionDetector: MotionDetector

    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            Color.green
                .edgesIgnoringSafeArea(.all)
                .opacity(motionDetector.isLevel ? 1 : 0)
            if !motionDetector.isMotionAvailable {
                Color.red
                    .edgesIgnoringSafeArea(.all)
            }
            BubbleLevel()
            OrientationDataView()
                .frame(width: 300, height: 300)
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
                                         
