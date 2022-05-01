/*
 See the License.txt file for this sample’s licensing information.
 */

import SwiftUI

struct FunFactsView: View {
    @State private var funFact = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text(funFact)
                    .padding()
                    .font(.title)
                    .frame(minHeight: 400)
                Button("Show Random Fact") {
                    funFact = information.funFacts.randomElement() ?? ""
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.cyan)
                .cornerRadius(15)
            }
            .padding()
            .navigationTitle("Fun Facts")
        }
    }
}

struct FunFactsView_Previews: PreviewProvider {
    static var previews: some View {
        FunFactsView()
    }
}
