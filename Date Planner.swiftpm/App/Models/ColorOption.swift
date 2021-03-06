/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct ColorOptions {
    static var all: [Color] = [
        .primary,
        .gray,
        .red,
        .orange,
        .yellow,
        .green,
        .mint,
        .cyan,
        .indigo,
        .purple
    ]
    
    static var `default`: Color = .primary
    
    static func random() -> Color {
        ColorOptions.all.randomElement() ?? self.default
    }
}
