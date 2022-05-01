/*
 See the License.txt file for this sample’s licensing information.
 */

import Foundation
import SwiftUI

struct Info {
    let image: String
    let name: String
    let story: String
    let hobbies: [String]
    let foods: [String]
    let colors: [Color]
    let funFacts: [String]
}

let information = Info(
    image: "Avatar",
    name: "An Trinh",
    story: """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed malesuada dictum blandit. Proin sed purus nec sapien bibendum convallis. Donec vestibulum massa eu metus scelerisque feugiat. Etiam dictum, sapien sit amet pellentesque elementum, risus massa faucibus tortor, nec fringilla quam felis quis nisi. Maecenas consectetur ornare ipsum, ac sollicitudin magna cursus vel. Sed faucibus dolor vel justo volutpat rutrum. Pellentesque facilisis at enim non semper. Pellentesque aliquet massa et nibh efficitur, at porta justo commodo. Praesent tempus justo neque, et faucibus nulla facilisis nec. Suspendisse efficitur pretium ante sed auctor.
    
    Cras quis semper nunc, ac ullamcorper arcu. Aenean auctor libero sed justo tincidunt, in consequat purus dignissim. Quisque vitae tellus dolor. Aenean pretium dui nec velit dignissim pulvinar. In enim tortor, consequat vel lacus non, tempus scelerisque erat. Phasellus commodo venenatis lectus venenatis volutpat. Quisque commodo pretium lectus et consequat. Vivamus tellus nulla, faucibus pretium sodales at, ultrices quis ligula. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Quisque nec aliquet lorem, in porttitor eros. Praesent hendrerit, quam sed convallis fringilla, mauris eros commodo leo, in iaculis urna orci at ligula. Donec at vehicula mauris. Quisque vehicula turpis id elit semper bibendum. Sed auctor convallis nulla, vitae venenatis lorem imperdiet nec. Fusce mauris enim, varius quis condimentum sit amet, facilisis nec sem. Donec in vestibulum arcu, non scelerisque lorem.
    
    Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed mattis nisi eu dignissim gravida. Mauris nec magna vel neque finibus mollis. Sed eget vestibulum est. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec mollis egestas finibus. Pellentesque dapibus mi neque, non rhoncus nunc aliquam sed. Aliquam vitae mi ac dolor auctor porttitor vitae vel risus. Quisque viverra ultrices mollis. Phasellus volutpat diam velit, vulputate dignissim quam tristique ac.
    """,
    hobbies: ["gamecontroller.fill", "ticket.fill", "chevron.left.forwardslash.chevron.right"],
    foods: ["🍙", "🍉", "🍜"],
    colors: [Color.black, Color.gray, Color.white],
    funFacts: [
        "The femur is the longest and largest bone in the human body.",
        "The moon is 238,900 miles away.",
        "Prince’s last name was Nelson.",
        "503 new species were discovered in 2020.",
        "Ice is 9 percent less dense than liquid water.",
        "You can spell every number up to 1,000 without using the letter A.\n\n...one, two, three, four...ninety-nine...nine hundred ninety-nine 🧐",
        "A collection of hippos is called a bloat.",
        "White sand beaches are made of parrotfish poop.",
    ]
)
