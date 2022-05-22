/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct GridView: View {
    @EnvironmentObject var dataModel: DataModel

    private static let initialColumns = 3
    @State private var isAddingPhoto = false
    @State private var editMode = EditMode.inactive

    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: initialColumns)
    @State private var numColumns = initialColumns

    private var isEditing: Bool { editMode == .active }

    var body: some View {
        VStack {
            if isEditing {
                Stepper("^[\(numColumns) Column](inflect: true)", value: $numColumns, in: 1...8, step: 1) { _ in
                    withAnimation {
                        gridColumns = Array(repeating: GridItem(.flexible()), count: numColumns)
                    }
                }
                .padding()
            }
            ScrollView {
                LazyVGrid(columns: gridColumns) {
                    ForEach(dataModel.items) { item in
                        GeometryReader { geo in
                            NavigationLink(destination: DetailView(item: item)) {
                                GridItemView(size: geo.size.width, item: item)
                            }
                        }
                        .cornerRadius(8.0)
                        .aspectRatio(1, contentMode: .fit)
                        .overlay(alignment: .topTrailing) {
                            if isEditing {
                                Button {
                                    withAnimation {
                                        dataModel.removeItem(item)
                                    }
                                } label: {
                                    Image(systemName: "xmark.square.fill")
                                                .font(Font.title)
                                                .symbolRenderingMode(.palette)
                                                .foregroundStyle(.white, .red)
                                }
                                .offset(x: 7, y: -7)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle("Image Gallery")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isAddingPhoto) {
            PhotoPicker() { url in
                dataModel.add(url: url)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isAddingPhoto = true
                } label: {
                    Image(systemName: "plus")
                }
                .disabled(isEditing)
            }
        }
        .environment(\.editMode, $editMode)
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
            .environmentObject(DataModel())
            .previewDevice("iPad (8th generation)")
    }
}
 
