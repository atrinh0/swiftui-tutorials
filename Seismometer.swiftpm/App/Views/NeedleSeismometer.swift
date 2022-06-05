/*
 See the License.txt file for this sample’s licensing information.
 */

import SwiftUI

struct NeedleSeismometer: View {
    @EnvironmentObject var motionDetector: MotionDetector

    private let needleAnchor = UnitPoint(x: 0.5, y: 1)
    private let amplification = 2.0
    private var rotationAngle: Angle {
        Angle(radians: -motionDetector.zAcceleration * amplification)
    }

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                ZStack(alignment: .bottom) {
                    GaugeBackground(width: 250)
                    Triangle()
                        .foregroundColor(.red)
                        .frame(width: 5, height: 150)
                        .rotationEffect(rotationAngle, anchor: needleAnchor)
                        .overlay {
                            VStack {
                                Spacer()
                                Circle()
                                    .stroke(lineWidth: 3)
                                    .fill()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(.red)
                                    .background {
                                        Color.white
                                            .clipShape(Circle())
                                    }
                                    .offset(x: 0, y: 5)
                            }
                        }
                }
                Spacer()
                Text("\(motionDetector.zAcceleration.describeAsFixedLengthString())")
                    .font(.system(.body, design: .monospaced))
                    .fontWeight(.bold)
                Spacer()
                Text("Set your device on a flat surface to record vibrations using its motion sensors.")
                    .padding()
                Spacer()
            }
            .navigationTitle(Text("Seismometer"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct NeedleSeismometer_Previews: PreviewProvider {
    @StateObject static private var detector = MotionDetector(updateInterval: 0.01).started()
    
    static var previews: some View {
        NeedleSeismometer()
            .environmentObject(detector)
    }
}
