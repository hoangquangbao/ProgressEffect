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
            }
        }
    }
}
