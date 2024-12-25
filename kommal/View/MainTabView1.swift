//
//  MainTabView1.swift
//  kommal
//
//  Created by hailah alsaudi on 22/06/1446 AH.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MainScreen1()
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                    Text("Browse")
                }
            
            MapScreen()
                .tabItem {
                    Image(systemName: "mappin.and.ellipse")
                    Text("Map")
                }
            
            VStack {
                Text("Chat with AI")
                    .font(.largeTitle)
            }
            .tabItem {
                Image(systemName: "apple.intelligence")
                Text("Chat")
            }
        }
        .accentColor(.blue)
    }
}

#Preview {
    MainTabView()
}

