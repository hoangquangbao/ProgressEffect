//
//  DetailView.swift
//  ProgressEffect
//
//  Created by Bao Hoang on 14/10/2023.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var selectCollect: Collect?
    @Binding var isShowDetail: Bool
    @Binding var heroProgress: CGFloat
    @Binding var isShowHeroView: Bool
    
    ///Gesture properties
    @GestureState private var isDragging: Bool = false
    @State private var offset: CGFloat = .zero
    
    @Environment(\.colorScheme) private var scheme
    
    var body: some View {
        if let selectCollect, isShowDetail {
            GeometryReader {
                let size = $0.size
                
                ScrollView(.vertical) {
                    ///Detail Collection Image
                    Rectangle()
                        .fill(.clear)
                        .overlay(content: {
                            Image(selectCollect.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: size.width, height: 400)
                                .clipped()
                                .hidden()
                        })
                        .frame(height: 400)
                    ///Destination Anchor Frame
                        .anchorPreference(key: AnchorKey.self, value: .bounds) {
                            return ["DESTINATION" : $0]
                        }
                }
                .edgesIgnoringSafeArea(.all)
                .frame(width: size.width, height: size.height)
                .background {
                    Rectangle()
                        .fill(scheme == .dark ? .black : .white)
                        .edgesIgnoringSafeArea(.all)
                }
                .overlay(alignment: .leading) {
                    Rectangle()
                        .fill(.clear)
                        .frame(width: 10)
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture()
                                .updating($isDragging) {_, out, _ in
                                    out = true
                                }
                                .onChanged({ value in
                                    var translation = value.translation.width
                                    translation = isDragging ? translation : .zero
                                    translation = translation > 0 ? translation : 0
                                    ///Converting into Progress
                                    let dragProgress = 1.0 - (translation / size.width)
                                    ///Limiting Progress btw 0...1
                                    let cappedProgress = min(max(0, dragProgress), 1)
                                    heroProgress = cappedProgress
                                    if isShowHeroView {
                                        isShowHeroView = true
                                    }
                                })
                                .onEnded({ value in
                                    ///Closing/Resetting based on End Target
//                                    let velocity = value.velocity.width
                                    let predictedEndLocation = value.predictedEndLocation
                                    let startLocation = value.startLocation
                                    let velocity = predictedEndLocation.x - startLocation.x


                                    
                                    if (offset + velocity) > (size.width * 0.7) {
                                        ///Close View
                                        withAnimation(Animation.easeInOut(duration: 0.35), {
                                            heroProgress = .zero
                                            offset = .zero
                                            isShowDetail = false
                                            isShowHeroView = true
                                            self.selectCollect = nil
                                        })
                                    } else {
                                        ///Reset
                                        withAnimation(Animation.easeInOut(duration: 0.35), {
                                            heroProgress = 1.0
                                            offset = .zero
                                            isShowHeroView = false
                                        })
                                    }
                                })
                        )
                }
            }
        }
    }
}
