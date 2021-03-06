/*
 See the License.txt file for this sample’s licensing information.
 */

import SwiftUI

struct SymbolGrid: View {
    @State private var isAddingSymbol = false
    @State private var editMode = EditMode.inactive

    private static let initialColumns = 3
    @State private var selectedSymbolName: String?
    @State private var numColumns = initialColumns
    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: initialColumns)

    @State private var symbols: [Symbol] = symbolNames.map { Symbol(name: $0) }

    private static let symbolNames = [
        "sun.max.fill",
        "lungs.fill",
        "gear",
        "allergens",
        "ladybug.fill",
        "faceid",
        "timer",
        "leaf.fill",
        "link.badge.plus",
        "moon.circle.fill",
        "sparkles",
        "circle.hexagongrid.fill"
    ]

    private var isEditing: Bool { editMode == .active }

    var body: some View {
        VStack {
            if isEditing {
                Stepper("^[\(numColumns) Column](inflect: true)", value: $numColumns, in: 1...6, step: 1) { _ in
                    withAnimation {
                        gridColumns = Array(repeating: GridItem(.flexible()), count: numColumns)
                    }
                }
                .padding()
            }
            ScrollView {
                LazyVGrid(columns: gridColumns) {
                    ForEach(symbols) { symbol in
                        NavigationLink(destination: ItemDetail(symbolName: symbol.name)) {
                            ZStack(alignment: .topTrailing) {
                                Image(systemName: symbol.name)
                                    .resizable()
                                    .scaledToFit()
                                    .symbolRenderingMode(.multicolor)
                                    .foregroundColor(.accentColor)
                                    .ignoresSafeArea(.container, edges: .bottom)
                                    .cornerRadius(8)
                                if isEditing {
                                    Button {
                                        remove(symbol: symbol)
                                    } label: {
                                        Image(systemName: "xmark.square.fill")
                                            .font(Font.title)
                                            .symbolRenderingMode(.palette)
                                            .foregroundStyle(.white, Color.red)
                                    }
                                    .offset(x: 7, y: -7)
                                }
                            }
                            .padding()
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .navigationBarTitle("My Symbols")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isAddingSymbol, onDismiss: addSymbol) {
            SymbolPicker(name: $selectedSymbolName)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isAddingSymbol = true
                } label: {
                    Image(systemName: "plus")
                }
                .disabled(isEditing)
            }
        }
        .environment(\.editMode, $editMode)
    }
    
    private func addSymbol() {
        guard let name = selectedSymbolName else { return }
        withAnimation {
            symbols.insert(Symbol(name: name), at: 0)
        }
        selectedSymbolName = nil
    }

    private func remove(symbol: Symbol) {
        guard let index = symbols.firstIndex(where: { $0 == symbol }) else { return }
        withAnimation {
            _ = symbols.remove(at: index)
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolGrid()
    }
}
