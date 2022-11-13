/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct ResetEllipse: View {
    var body: some View {
        Ellipse()
            .frame(width: 200, height: 200)
            .foregroundColor(.orange)
    }
}
struct SpinningEllipse: View {
        @State private var width: CGFloat = 200

        var body: some View {
            Ellipse()
                .frame(width: width, height: 200)
                .foregroundColor(.orange)
                .onAppear {
                    withAnimation(.easeInOut.repeatForever(autoreverses: true).speed(2)) {
                        width = 0
                    }
                }
        }
}
struct SpinningView: View {
    @State private var isSpinning = false
    
    var body: some View {
        VStack {
            
            Spacer()
            
            if isSpinning {
                SpinningEllipse()
            } else {
                ResetEllipse()
            }
            
            Spacer()
            
            PlayResetButton(animating: $isSpinning) 
        }
        .navigationTitle("Spinning Animation")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SpinningView_Previews: PreviewProvider {
    static var previews: some View {
        SpinningView()
    }
}


