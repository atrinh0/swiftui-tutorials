/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct BasicShapesView: View {
    @State private var trimStart : Double = 0
    @State private var trimEnd : Double = 1
    @State private var width : Double = 1
    @State private var height : Double = 1
    @State private var selectedShape : ShapeType = .circle

    var body: some View {
        VStack {
            Text(selectedShape.rawValue)
                .font(.largeTitle)
                .padding(.top, 30)
            
            TabView(selection: $selectedShape) {
                Group {
                    Circle()
                        .trim(from: trimStart, to: trimEnd)
                        .tag(ShapeType.circle)
                        
                    Capsule()
                        .trim(from: trimStart, to: trimEnd)
                        .tag(ShapeType.capsule)

                    Rectangle()
                        .trim(from: trimStart, to: trimEnd)
                        .tag(ShapeType.rectangle)

                    Ellipse()
                        .trim(from: trimStart, to: trimEnd)
                        .tag(ShapeType.ellipse)

                    RoundedRectangle(cornerRadius: 20)
                        .trim(from: trimStart, to: trimEnd)
                        .tag(ShapeType.roundedRectangle)
                    
                    Heart()
                        .trim(from: trimStart, to: trimEnd)
                        .tag(ShapeType.customPath)
                        
                }
                .foregroundStyle(LinearGradient(colors: [.indigo, .teal], startPoint: .bottom, endPoint: .top))
                .frame(maxWidth: width * 150, maxHeight: height * 150)
                .padding()
                .padding(.bottom, 50)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
         
            Group {
                HStack {
                    Text("Width")
                    Slider(value: $width)
                }
                
                HStack {
                    Text("Height")
                    Slider(value: $height)
                }
                
                HStack {
                    Text("Trim Start")
                    Slider(value: $trimStart)
                }
                
                HStack {
                    Text("Trim End")
                    Slider(value: $trimEnd)
                }
            }
            .padding(.vertical, 10)
        }
        .padding()
        .navigationTitle("Basic Shapes")
        .navigationBarTitleDisplayMode(.inline)
    }
}

enum ShapeType : String {
    case circle = "Circle"
    case rectangle = "Rectangle"
    case capsule = "Capsule"
    case ellipse = "Ellipse"
    case roundedRectangle = "Rounded Rectangle"
    case customPath = "Custom Path"
}

struct BasicShapesView_Previews: PreviewProvider {
    static var previews: some View {
        BasicShapesView()
    }
}
