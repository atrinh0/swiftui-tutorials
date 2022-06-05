/*
 See the License.txt file for this sample’s licensing information.
 */

import SwiftUI

struct GraphSeismometer: View {
    @EnvironmentObject private var detector: MotionDetector
    @State private var data = [Double]()
    private let maxData = 1000

    @State private var sensitivity = 0.0
    private let graphMaxValueMostSensitive = 0.01
    private let graphMaxValueLeastSensitive = 1.0

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                LineGraph(data: data, maxData: maxData, minValue: graphMinValue, maxValue: graphMaxValue)
                    .clipped()
                    .background(Color.primary.opacity(0.1))
                    .cornerRadius(20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.primary, lineWidth: 1)
                            .opacity(0.5)
                    }
                    .padding()
                    .aspectRatio(1, contentMode: .fit)
                Spacer()
                Text("Sensitivity")
                    .font(.headline)
                Slider(value: $sensitivity, in: 0...1, minimumValueLabel: Text("Min"), maximumValueLabel: Text("Max")) {
                    Text("Sensitivity")
                }
                .padding()
                Spacer()
                Text("Set your device on a flat surface to record vibrations using its motion sensors.")
                    .padding()
                Spacer()
            }
            .navigationTitle(Text("Seismometer"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            detector.onUpdate = {
                data.append(-detector.zAcceleration)
                if data.count > maxData {
                    data = Array(data.dropFirst())
                }
            }
        }
    }

    private var graphMaxValue: Double {
        graphMaxValueMostSensitive + (1 - sensitivity) * (graphMaxValueLeastSensitive - graphMaxValueMostSensitive)
    }

    private var graphMinValue: Double {
        -graphMaxValue
    }
}

struct GraphSeismometer_Previews: PreviewProvider {
    @StateObject static private var detector = MotionDetector(updateInterval: 0.01).started()

    static var previews: some View {
        GraphSeismometer()
            .environmentObject(detector)
    }
}
