/*
See the License.txt file for this sample’s licensing information.
*/

import CoreMotion
import UIKit
import SwiftUI

class MotionDetector: ObservableObject {
    private let motionManager = CMMotionManager()

    private var timer = Timer()
    private var updateInterval: TimeInterval

    @Published var pitch: Double = 0
    @Published var roll: Double = 0
    @Published var zAcceleration: Double = 0
    @Published var isLevel = false
    @Published var isMotionAvailable = false

    private var currentOrientation: UIDeviceOrientation = .portrait
    private var orientationObserver: NSObjectProtocol? = nil
    private let notification = UIDevice.orientationDidChangeNotification

    init(updateInterval: TimeInterval) {
        self.updateInterval = updateInterval
    }
    
    func start() {
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        orientationObserver = NotificationCenter.default.addObserver(forName: notification, object: nil, queue: .main) { [weak self] _ in
            switch UIDevice.current.orientation {
            case .faceUp, .faceDown, .unknown:
                break
            default:
                self?.currentOrientation = UIDevice.current.orientation
            }
        }

        isMotionAvailable = motionManager.isDeviceMotionAvailable
        
        if isMotionAvailable {
            motionManager.startDeviceMotionUpdates()
            
            timer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { _ in
                self.updateMotionData()
            }
        } else {
            print("Motion data isn't available on this device.")
        }
    }
    
    func started() -> MotionDetector {
        start()
        return self
    }

    func stop() {
        motionManager.stopDeviceMotionUpdates()
        timer.invalidate()
        if let orientationObserver = orientationObserver {
            NotificationCenter.default.removeObserver(orientationObserver, name: notification, object: nil)
        }
        orientationObserver = nil
    }

    deinit {
        stop()
    }
}

extension MotionDetector {
    private func updateMotionData() {
        guard let data = motionManager.deviceMotion else { return }

        (roll, pitch) = currentOrientation.adjustedRollAndPitch(data.attitude)
        zAcceleration = data.userAcceleration.z
        withAnimation {
            isLevel = abs(roll) < 0.02 && abs(pitch) < 0.02
        }
    }
}

extension UIDeviceOrientation {
    func adjustedRollAndPitch(_ attitude: CMAttitude) -> (roll: Double, pitch: Double) {
        switch self {
        case .unknown, .faceUp, .faceDown:
            return (attitude.roll, -attitude.pitch)
        case .landscapeLeft:
            return (attitude.pitch, -attitude.roll)
        case .portrait:
            return (attitude.roll, attitude.pitch)
        case .portraitUpsideDown:
            return (-attitude.roll, -attitude.pitch)
        case .landscapeRight:
            return (-attitude.pitch, attitude.roll)
        @unknown default:
            return (attitude.roll, attitude.pitch)
        }
    }
}
