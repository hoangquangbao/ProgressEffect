//
//  Home.swift
//  ProgressEffect
//
//  Created by Bao Hoang on 14/10/2023.
//

import SwiftUI

struct Home: View {
    
    ///View properties
    @State private var allCollects: [Collect] = collects
    ///Details properties
    @State private var selectCollect: Collect?
    @State private var isShowDetail: Bool = false
    @State private var heroProgress: CGFloat = 0
    @State private var isShowHeroView: Bool = false
    var body: some View {
        NavigationStack {
            List(allCollects) { collect in
                HStack(spacing: 12) {
                    Image(collect.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .anchorPreference(key: AnchorKey.self,
                                          value: .bounds) {
                            return [collect.id.uuidString : $0]
                        }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(collect.imageName)
                            .fontWeight(.semibold)
                            .foregroundStyle(.linearGradient(colors: [.green, .orange], startPoint: .leading, endPoint: .trailing))
                        
                        Text(collect.description)
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectCollect = collect
                    isShowDetail = true
                    
                    withAnimation(Animation.easeInOut(duration: 0.35)) {
                        heroProgress = 1.0
                    }
                    withAnimation(Animation.easeInOut(duration: 0.35).delay(0.2)) {
                        isShowHeroView = true
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Progress Effect")
        }
        .overlay {
            if isShowDetail {
                DetailView(selectCollect: $selectCollect,
                           isShowDetail: $isShowDetail,
                           heroProgress: $heroProgress,
                           isShowHeroView: $isShowHeroView)
                .transition(.identity)
            }
        }
        ///Hero Animation Layer
        .overlayPreferenceValue(AnchorKey.self, { value in
            GeometryReader { geometry in
                ///Let's Check Whether We Have Both Source and Destination Frames
                if let selectCollect,
                   let source = value[selectCollect.id.uuidString],
                   let destination = value["DESTINATION"] {
                    let sourceRect = geometry[source]
                    let radius = sourceRect.height / 2
                    let destinationRect = geometry[destination]
                    
                    let diffSize = CGSize(width: destinationRect.width - sourceRect.width,
                                          height: destinationRect.height - sourceRect.height)
                    
                    let diffOrigin = CGPoint(x: destinationRect.minX - sourceRect.minX,
                                             y: destinationRect.minY - sourceRect.minY)
                    ///Your Hero View
                    ///Mins is just a collect image
                    Image(selectCollect.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: sourceRect.width + (diffSize.width * heroProgress),
                               height: sourceRect.height + (diffSize.height * heroProgress))
                        .clipShape(RoundedRectangle(cornerRadius: radius))
                        .offset(x: sourceRect.minX + (diffOrigin.x * heroProgress),
                                y: sourceRect.minY + (diffOrigin.y * heroProgress))
                    //                        .opacity(isShowHeroView ? 1 : 0)
                        .overlay(alignment: .topLeading, content: {
                            if isShowHeroView {
                                Button {
                                    isShowDetail = false
                                    self.selectCollect = nil
                                    isShowHeroView = false
                                    heroProgress = 0.0
                                } label: {
                                    Image(systemName: "xmark.square.fill")
                                        .font(.largeTitle)
                                        .imageScale(.medium)
                                        .foregroundStyle(.white, .black)
                                        .padding(.leading)
                                }
                            }
                        })
                }
            }
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
