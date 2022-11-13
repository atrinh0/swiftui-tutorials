/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct ShapesButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(minWidth: 125, minHeight: 60)
            .background(Color.blue.opacity(0.15))
            .foregroundColor(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.bottom, 30)
    }
}

struct PlayResetButton: View {
    @Binding var animating: Bool
    var resetOnly : Bool = false
    var action: () -> Void = { }
     
    init(animating: Binding<Bool>, resetOnly: Bool = false, action: @escaping () -> Void = {}){
        self._animating = animating
        self.resetOnly = resetOnly
        self.action = action
     }

    var body: some View {
        Button() {
            animating.toggle()
            action()
        } label: {
            if resetOnly {
                Label("Reset", systemImage: "arrow.counterclockwise")
            } else {
                Label(animating ? "Reset": "Play", systemImage: animating ? "arrow.counterclockwise" : "play.fill")
            }
           
        }
        .buttonStyle(ShapesButton())
        
    }
}
