/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct GridItemView: View {
    let size: CGFloat
    let item: Item

    var body: some View {
        ZStack {
            AsyncImage(url: item.url) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: size, height: size)
        }
    }
}

struct GridItemView_Previews: PreviewProvider {
    static var previews: some View {
        if let url = Bundle.main.url(forResource: "bobcat", withExtension: "jpg") {
            GridItemView(size: 50, item: Item(url: url))
        }
    }
}
