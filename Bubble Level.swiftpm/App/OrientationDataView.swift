/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct OrientationDataView: View {
    @EnvironmentObject var detector: MotionDetector

    var body: some View {
        Text(averagePitchAndRollString)
            .font(.system(size: 70))
            .foregroundStyle(.white)
            .rotationEffect(rotationAngle)
            .blendMode(.difference)
    }

    private var averagePitchAndRollString: String {
        let roll = abs(detector.roll)
        let pitch = abs(detector.pitch)
        return (-sqrt(roll * roll + pitch * pitch)).describeAsFixedLengthString()
    }

    private var rotationAngle: Angle {
        Angle(radians: -atan2(detector.roll, detector.pitch))
    }
}

struct OrientationDataView_Previews: PreviewProvider {
    @StateObject static private var motionDetector = MotionDetector(updateInterval: 0.01).started()
    
    static var previews: some View {
        OrientationDataView()
            .environmentObject(motionDetector)
    }
}
