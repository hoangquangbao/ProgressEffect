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
    @State var isShowDetails: Bool = false
    
    var body: some View {
        NavigationStack {
            List(allCollects) { collect in
                HStack(spacing: 12) {
                    Image(collect.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    
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
                    isShowDetails = true
                }
            }
            .listStyle(.plain)
            .navigationTitle("Progress Effect")
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
