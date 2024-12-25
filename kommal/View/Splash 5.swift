//
//  Splash 5.swift
//  kommal
//
//  Created by hailah alsaudi on 24/06/1446 AH.
//


import SwiftUI
import AVKit
import WebKit

struct Splash: View {
    @State private var player = AVPlayer()
    @State private var isActive = false // للتحكم بالتنقل

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: .init(colors: [.blu1, .blu2, .blu3, .blu4]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                VStack {
                    Circle()
                        .fill(Color.circle.opacity(0.19)) // شفافية 50%
                        .frame(width: 562, height: 612)
                        .offset(y: -225) // حجم الدائرة
                }
                ZStack {
                    Circle()
                        .fill(Color.circle.opacity(0.19)) // شفافية 50%
                        .frame(width: 562, height: 612)
                        .offset(y: 200) // حجم الدائرة
                }

                GifImage("Sp")
            }
            // الانتقال إلى الصفحة الرئيسية
            .navigationDestination(isPresented: $isActive) {
                MainScreen() // الصفحة الرئيسية
            }
        }
        .onAppear {
            // تأخير الانتقال لمدة 3 ثوانٍ
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isActive = true
            }
        }
    }
}

struct MainScreen: View {
    var body: some View {
        Text("Welcome to Main Screen")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
    }
}

#Preview {
    Splash()
}
