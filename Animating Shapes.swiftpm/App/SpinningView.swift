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
    @State private var isAnimating = false

    var body: some View {
        Ellipse()
            .frame(width: 200, height: 200)
            .foregroundColor(.orange)
            .overlay {
                Image(systemName: "sterlingsign")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.white)
            }
            .rotation3DEffect(.degrees(isAnimating ? 0 : 360), axis: (x: 0, y: 1, z: 0))
            .onAppear {
                withAnimation(.easeInOut.repeatForever(autoreverses: false).speed(0.25)) {
                    isAnimating = true
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


