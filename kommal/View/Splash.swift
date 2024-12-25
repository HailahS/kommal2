//
//  splash.swift
//  kommal
//
//  Created by Ghada al ajmi on 15/06/1446 AH.
//
import SwiftUI
import AVKit
import WebKit

struct Splash: View {
    @State private var player = AVPlayer()
    @State private var isActive = false // التحكم بالانتقال
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: .init(colors: [.blu1, .blu2, .blu3, .blu4]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                VStack {
                    Circle()
                        .fill(Color.circle.opacity(0.19))
                        .frame(width: 562, height: 612)
                        .offset(y: -225)
                }
                ZStack {
                    Circle()
                        .fill(Color.circle.opacity(0.19))
                        .frame(width: 562, height: 612)
                        .offset(y: 200)
                }

                GifImage("Sp")
            }
            .navigationDestination(isPresented: $isActive) {
                MainScreen1() // التأكد من كتابة الاسم كما هو
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                isActive = true
            }
        }
    }
}

#Preview {
    Splash()
}
