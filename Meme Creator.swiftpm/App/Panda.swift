/*
 See the License.txt file for this sample’s licensing information.
 */

import SwiftUI

struct Panda: Decodable, Hashable {
    var description: String
    var imageUrl: URL?
    
    static let defaultPanda = Panda(description: "Cute Panda",
                                    imageUrl: URL(string: "https://playgrounds-cdn.apple.com/assets/pandas/pandaBuggingOut.jpg"))
}

struct PandaCollection: Decodable {
    var sample: [Panda]
}
