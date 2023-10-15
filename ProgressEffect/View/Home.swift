//
//  Home.swift
//  ProgressEffect
//
//  Created by Bao Hoang on 14/10/2023.
//

import SwiftUI

struct Home: View {
    
    ///View properties
    @State var allCollects: [Collect] = collects
    ///Details properties
    @State var selectCollect: Collect?
    @State var isShowDetail: Bool = false
    
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
                    withAnimation(.easeOut(duration: 0.25)) {
                        isShowDetail = true
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Progress Effect")
        }
        .overlay {
            if isShowDetail {
                DetailView(selectCollect: $selectCollect,
                           isShowDetail: $isShowDetail)
                .transition(.move(edge: .bottom))
//                .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
