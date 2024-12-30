import SwiftUI

struct SignUp: View {
    @State private var username: String = ""  // لتخزين اسم المستخدم
    @StateObject private var viewModel = ViewModel() // لتخزين الـ ViewModel
    @State private var isLoading: Bool = false  // لتحديد حالة التحميل
    @State private var isUserSaved: Bool = false  // لتحديد ما إذا تم حفظ المستخدم بنجاح

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
                ZStack {
                    Circle()
                        .fill(Color.circle.opacity(0.19)) // شفافية 50%
                        .frame(width: 562, height: 612).offset(y: 200) // حجم الدائرة
                }
                
                VStack(spacing: 40) {
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
                    }
                    
                    // زر التسجيل
                    Button(action: {
                        if !username.isEmpty {
                            // بدء التحميل
                            isLoading = true
                            // مناداة دالة addUser مع الـ completion handler
                            viewModel.addUser(userName: username) { result in
                                isLoading = false // إيقاف التحميل
                                switch result {
                                case .success:
                                    print("User saved successfully")
                                    isUserSaved = true // تعيين المستخدم المحفوظ
                                case .failure(let error):
                                    print("Failed to save user: \(error.localizedDescription)")
                                }
                            }
                        } else {
                            print("Please enter a username")
                        }
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

                    // عرض ProgressView أثناء التحميل
                    if isLoading {
                        ProgressView("Saving user...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                    }
                    
                    // التنقل إلى MainScreen1 عندما يتم حفظ المستخدم بنجاح
                    // هذه هي الفكرة: استخدم NavigationLink هنا مع تفعيل التنقل بعد نجاح الحفظ
                    NavigationLink(destination: MainScreen1(), isActive: $isUserSaved) {
                        EmptyView()  // رابط التنقل الذي يكون غير مرئي ولكن يتم تفعيله بناءً على isUserSaved
                    }
                }
                .padding()
                .cornerRadius(20)
                .shadow(radius: 5)
            }
        }
    }
}

#Preview {
    SignUp()
}

