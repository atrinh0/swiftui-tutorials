/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct FavouritesView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Hobbies")
                    .font(.title2)

                HStack(spacing: 30) {
                    ForEach(information.hobbies, id: \.self) { hobby in
                        Image(systemName: hobby)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 70, maxHeight: 70)

                    }
                }
                .padding()

                Text("Foods")
                    .font(.title2)

                HStack(spacing: 30) {
                    ForEach(information.foods, id: \.self) { food in
                        Text(food)
                            .font(.system(size: 70))
                    }
                }
                .padding()

                Text("Colours")
                    .font(.title2)

                HStack(spacing: 30) {
                    ForEach(information.colors, id: \.self) { color in
                        Circle()
                            .strokeBorder(Color.primary.opacity(0.25), lineWidth: 1)
                            .background(Circle()
                                .foregroundColor(color))
                            .frame(width: 70, height: 70)
                    }
                }
                .padding()
            }
            .navigationTitle("Favourites")
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
