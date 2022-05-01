/*
 See the License.txt file for this sample’s licensing information.
 */

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(information.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(25)
                    .padding(40)
                Text(information.name)
                    .font(.title)
            }
            .navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
