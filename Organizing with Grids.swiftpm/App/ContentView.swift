/*
 See the License.txt file for this sample’s licensing information.
 */


import SwiftUI

struct ContentView: View {
    @State private var selectedColor = Color.gray

    private let columnLayout = Array(repeating: GridItem(), count: 3)
    private let allColors: [Color] = [
        .pink,
        .red,
        .orange,
        .yellow,
        .green,
        .mint,
        .teal,
        .cyan,
        .blue,
        .indigo,
        .purple,
        .brown,
        .gray
    ]

    let cols: Int = 3
    let spacing: CGFloat = 3
    let imgSize = CGSize(width: 120, height: 120)
    var hexagonWidth: CGFloat { (imgSize.width / 2) * cos(.pi / 6) * 2 }

    var body: some View {
        let gridItems = Array(repeating: GridItem(.fixed(hexagonWidth), spacing: spacing), count: cols)
        VStack {
            Text("Selected Colour")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(selectedColor)
                .padding(10)
            ScrollView(.vertical) {
                LazyVGrid(columns: gridItems, spacing: spacing) {
                    ForEach(allColors, id: \.description) { color in
                        VStack(spacing: 0) {
                            Button {
                                selectedColor = color
                            } label: {
                                color
                                    .frame(width: imgSize.width, height: imgSize.height)
                                    .clipShape(PolygonShape(sides: 6).rotation(Angle.degrees(90)))
                                    .offset(x: isEvenRow(allColors.firstIndex(of: color) ?? 0) ? 0 : hexagonWidth/2 + (spacing/2))
                            }
                            .buttonStyle(.plain)
                        }
                        .frame(width: hexagonWidth, height: imgSize.height * 0.75)
                    }
                }
                .frame(width: (hexagonWidth + spacing) * CGFloat(cols + 1))
                .offset(x: -(hexagonWidth + spacing)/4, y: (hexagonWidth + spacing)/4)
            }
        }
    }

    func isEvenRow(_ idx: Int) -> Bool {
        (idx / cols) % 2 == 0
    }
}

// https://swiftui-lab.com/impossible-grids/
struct PolygonShape: Shape {
    let sides: Int

    func path(in rect: CGRect) -> Path {
        let h = Double(min(rect.size.width, rect.size.height)) / 2.0
        let c = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
        var path = Path()

        for i in 0..<sides {
            let angle = (Double(i) * (360.0 / Double(sides))) * Double.pi / 180

            let pt = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))

            if i == 0 {
                path.move(to: pt) // move to first vertex
            } else {
                path.addLine(to: pt) // draw line to next vertex
            }
        }

        path.closeSubpath()

        return path
    }
}
