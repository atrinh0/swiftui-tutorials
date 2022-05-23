//
//  PandaPicker.swift
//  
//
//  Created by An Trinh on 23/05/2022.
//

import SwiftUI

struct PandaPicker: View {
    @EnvironmentObject var fetcher: PandaCollectionFetcher
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                    ForEach(fetcher.imageData.sample, id: \.self) { item in
                        GeometryReader { geo in
                            Button {
                                fetcher.currentPanda = item
                                dismiss()
                            } label: {
                                AsyncImage(url: item.imageUrl) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .overlay {
                                            if fetcher.currentPanda.imageUrl == item.imageUrl {
                                                ZStack {
                                                    Color.primary.colorInvert().opacity(0.75)
                                                    Image(systemName: "checkmark.circle.fill")
                                                        .font(.largeTitle)
                                                        .accentColor(.primary)
                                                }
                                            }
                                        }
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: geo.size.width, height: geo.size.width)
                            }
                        }
                        .cornerRadius(8.0)
                        .aspectRatio(1, contentMode: .fit)
                    }
                }
                .padding()
            }
            .navigationTitle("Select Image")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}
