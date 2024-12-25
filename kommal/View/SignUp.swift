import SwiftUI

struct SignUp: View {
    @State private var username: String = "" // لتخزين إدخال اسم المستخدم
    @State private var password: String = "" // لتخزين إدخال كلمة المرور
    @State private var isSheetPresented = false
    
    var body: some View {
        NavigationStack { // إضافة NavigationStack للتنقل بين الشاشات
            ZStack {
                // الخلفية المتدرجة
                LinearGradient(gradient: .init(colors: [.blu1, .blu2, .blu3, .blu4]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    // الدوائر الخلفية
                    Circle()
                        .fill(Color.circle.opacity(0.19))
                        .frame(width: 562, height: 612)
                        .offset(y: -225)
                    
                    
                }
                ZStack{
                    Circle()
                        .fill(Color.circle.opacity(0.19)) // شفافية 50%
                        .frame(width: 562, height: 612).offset(y:200)// حجم الدائرة
                    
                }
                
                VStack(spacing: 10) {
                    // الشعار
                    Image("logo1")
                        .frame(width: 150, height: 150)
                    
                    // البطاقة البيضاء
                    VStack(spacing: 30) {
                        // حقل اسم المستخدم
                        TextField("Username", text: $username)
                            .padding()
                            .frame(width: 290.0, height: 50.0)
                            .background(Color.white)
                            .cornerRadius(7)
                        
                        
                        // حقل كلمة المرور
                        SecureField("Password", text: $password)
                            .padding()
                            .frame(width: 290.0, height: 50.0)
                            .background(Color.white)
                            .cornerRadius(7)
                        
                        
                        HStack {
                            Text("I don't have an account")
                                .foregroundColor(.white)
                            
                            Button("Sign up") {
                                // إظهار الشيت عند الضغط
                                isSheetPresented = true
                            }
                            .foregroundColor(.ylw)
                            .fontWeight(.bold)
                        }
                        
                        .sheet(isPresented: $isSheetPresented){
                            // محتوى الشيت
                            RegistrationSheet().presentationDetents([.height(550)])
                        }
                        
                        .padding(.vertical, 5.0)
                        .overlay(
                            Rectangle()
                                .frame(height: 1) // ارتفاع الخط
                                .foregroundColor(.white) // لون الخط
                                .padding(.top, 35), // مسافة بين النص والخط
                            alignment: .bottom
                        )
                        // زر التسجيل
                        Button(action: {
                            // الإجراء عند النقر
                            print("Get Started: \(username), \(password)")
                        }) {
                            Text("Get Started")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .frame(width: 140.0, height: 50.0)
                                .background(Color.ylw)
                                .cornerRadius(7)
                        }
                        .padding()
                        
                        // زر Continue as a guest
                        NavigationLink(destination: MainScreen1()) {
                            Text("Continue as a guest")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .padding(.vertical)
                    }
                }
                .padding()
                .cornerRadius(20)
                .shadow(radius: 5)
                //  .padding(.horizontal,20) // لتوسيط البطاقة
            }
        }
    } }
    
    // كود محتوى الشيت
  

#Preview {
    SignUp()
}
