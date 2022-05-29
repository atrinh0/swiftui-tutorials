/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

@main
struct SeismometerApp: App {
    @StateObject private var detector = MotionDetector(updateInterval: 0.01)

    var body: some Scene {
        WindowGroup {
            TabView {
                NeedleSeismometer()
                    .tabItem {
                        Label("Needle", systemImage: "gauge")
                    }
                GraphSeismometer()
                    .tabItem {
                        Label("Graph", systemImage: "waveform.path.ecg.rectangle")
                    }
            }
            .environmentObject(detector)
            .onAppear() {
                detector.start()
            }
            .onDisappear {
                detector.stop()
            }
        }
    }
}
