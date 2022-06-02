//
//  GestureView.swift
//  
//
//  Created by An Trinh on 02/06/2022.
//

import SwiftUI

struct GestureView: View {
    @State private var color: Color = Color.primary
    private var tapGesture: some Gesture {
        TapGesture()
            .onEnded {
                withAnimation {
                    color = Color.random()
                }
            }
    }
    
    @State private var size: CGSize = CGSize(width: randomDimension,
                                             height: randomDimension)
    private var longPressGesture: some Gesture {
        LongPressGesture()
            .onEnded { value in
                withAnimation {
                    self.size = CGSize(width: GestureView.randomDimension,
                                       height: GestureView.randomDimension)
                }
            }
    }
    
    @State private var offset = CGSize.zero
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                offset = CGSize(width: value.startLocation.x + value.translation.width - size.width/2,
                                height: value.startLocation.y + value.translation.height - size.height/2)
            }
    }
    
    @State private var rotation = Angle.zero
    private var rotationGesture: some Gesture {
        RotationGesture()
            .onChanged{ angle in
                rotation = angle
            }
            .onEnded { angle in
                rotation = angle
            }
    }
    
    @State private var lineStart = CGPoint.zero
    @State private var lineEnd = CGPoint.zero
    private var lineDrawingGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                lineStart = value.startLocation
                lineEnd = value.location
            }
            .onEnded { value in
                lineEnd = value.location
            }
    }
        
    var body: some View {
            Capsule()
                .foregroundColor(color)
                .frame(width: size.width, height: size.height)
                .rotationEffect(rotation)
                .offset(offset)
                .gesture(tapGesture)
                .gesture(longPressGesture)
                .gesture(dragGesture)
                .gesture(rotationGesture)
    }
    
    private static var randomDimension: CGFloat {
        // between 40-250
        CGFloat(arc4random() % 210 + 40)
    }
}