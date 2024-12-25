//
//  OpenAI.swift
//  kommal
//
//  Created by Ghada al ajmi on 14/06/1446 AH.
//

import SwiftUI

struct OpenAI: View {
    var body: some View {
      
            ZStack {
                Color.bg.ignoresSafeArea()
                
                VStack {
                    // الشريط العلوي
                    HStack {
                        // زر العودة
                        Button(action: {
                            print("Back tapped")
                        }) {
                            
                            Image(systemName: "chevron.backward") // أيقونة العودة
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                            
                        }
                        
                        Spacer()
                        
                        // النص أو الصورة للملف الشخصي
                        HStack {
                            
                            Button(action: {
                                print("chevron.backward")
                            }) {
                                Image(systemName: "person.circle.fill") // صورة الملف الشخصي
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 44, height: 44)  .foregroundColor(.white).padding()
                                // إضافة مسافة صغيرة بين الأيقونة والنص
                            }
                        }
                        
                    }
                    .frame(height: 60) // تقليص حجم الشريط العلوي
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: .blu4, location: -0.2),
                                .init(color: .blu2, location: 0.50),
                                .init(color: .blu2, location: 0.50),
                                .init(color: .blu1, location: 1.0)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ).ignoresSafeArea()
                    ) // لون الشريط العلوي
                    
                    
                    
                    
                    Spacer() // محتوى التطبيق الرئيسي
                    Text("Main Content")
                        .font(.largeTitle)
                    Spacer()
                    
                    
                    
                    
                    
                    
                    // الشريط السفلي
                    // خلفية الشريط السفلي
                }
            }
            
       
        
        .accentColor(.circle)
        .background(Color.white)
        }
}

#Preview {
    OpenAI()
}
