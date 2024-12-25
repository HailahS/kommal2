//
//  MainScreen1 2.swift
//  kommal
//
//  Created by hailah alsaudi on 22/06/1446 AH.
//


import SwiftUI

struct MainScreen1: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: .blu4, location: -0.00),
                    .init(color: .blu2, location: 0.110),
                    .init(color: .blu2, location: 0.110),
                    .init(color: .bg, location: 0.40),
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        print("Back tapped")
                    }) {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        print("Profile tapped")
                    }) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                
                Spacer()
                Text("Main Content").font(.largeTitle)
                Spacer()
            }
        }
    }
}

#Preview {
    MainScreen1()
}
