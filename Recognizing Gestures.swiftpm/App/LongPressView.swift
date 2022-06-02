/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct LongPressView: View {
    @State private var size: CGSize = CGSize(width: randomDimension,
                                             height: randomDimension)
    
    var longPressGesture: some Gesture {
        LongPressGesture()
            .onEnded { value in
                withAnimation {
                    self.size = CGSize(width: LongPressView.randomDimension,
                                       height: LongPressView.randomDimension)
                }
            }
    }
    
    var body: some View {
        VStack {
            Text("Touch and hold the capsule to change its size")
            Spacer()
            Capsule()
                .foregroundColor(.yellow)
                .frame(width: size.width, height: size.height)
                .gesture(longPressGesture)
            Spacer()
        }
        .navigationTitle("Touch and Hold")
    }
    
    private static var randomDimension: CGFloat {
        // between 40-250
        CGFloat(arc4random() % 210 + 40)
    }
}

struct LongPressView_Previews: PreviewProvider {
    static var previews: some View {
        LongPressView()
    }
}
