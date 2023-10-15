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
                    Image(selectCollect.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: size.width, height: 400)
                        .clipped()
                }
                .edgesIgnoringSafeArea(.all)
                .frame(width: size.width, height: size.height)
                .background {
                    Rectangle()
                        .fill(scheme == .dark ? .black : .white)
                        .edgesIgnoringSafeArea(.all)
                }
                ///Close button
                .overlay(alignment: .topLeading, content: {
                    Image(systemName: "xmark.square.fill")
                        .font(.largeTitle)
                        .imageScale(.medium)
                        .foregroundStyle(.white, .black)
                        .padding(.leading)
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 0.25)) {
                                isShowDetail = false
                            }
                            self.selectCollect = nil
                        }
                })
            }
        }
    }
}
