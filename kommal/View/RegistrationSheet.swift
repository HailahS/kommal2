//
//  RegistrationSheet.swift
//  kommal
//
import SwiftUI
import CloudKit

struct RegistrationSheet: View {
    @Environment(\.dismiss) private var dismiss // لإغلاق الشيت
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var phoneNumber: String = ""
    @State private var confirmPassword: String = ""
    
    @StateObject private var cloudKitManager = CloudKitManager()
    @State private var message: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                // تغيير لون الخلفية إلى البيج وملء الشاشة
                Color("bg").ignoresSafeArea()

                VStack {
                    Spacer() // لإضافة مسافة في الأعلى
                    
                    // العنوان وزر الإغلاق
                    HStack {
                        Text("Create Account")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button(action: {
                            dismiss() // إغلاق الشيت
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.gray)
                                .padding()
                                .frame(width: 25.0, height: 25.0)
                                .background(Color.white.opacity(0.7))
                                .clipShape(Circle())
                                .shadow(radius: 2)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)

                    // خط فاصل
                    Divider()
                        .background(Color.gray.opacity(0.5))
                        .padding(.horizontal, 20)

                    // خانات الإدخال مع الرموز
                    VStack(spacing: 20) {
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.gray)
                            TextField("Username", text: $userName)
                        }
                        .padding()
                        .frame(width: 300.0, height: 50.0)
                        .background(Color.white)
                        .cornerRadius(7)

                        HStack {
                            Image(systemName: "phone.fill")
                                .foregroundColor(.gray)
                            TextField("Phone Number", text: $phoneNumber)
                                .keyboardType(.phonePad)
                        }
                        .padding()
                        .frame(width: 300.0, height: 50.0)
                        .background(Color.white)
                        .cornerRadius(7)

                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.gray)
                            SecureField("Password", text: $password)
                        }
                        .padding()
                        .frame(width: 300.0, height: 50.0)
                        .background(Color.white)
                        .cornerRadius(7)

                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.gray)
                            SecureField("Confirm Password", text: $confirmPassword)
                        }
                        .padding()
                        .frame(width: 300.0, height: 50.0)
                        .background(Color.white)
                        .cornerRadius(7)

                        Button(action: {
                            // تحقق من صحة المدخلات قبل حفظ البيانات
                            if userName.isEmpty || phoneNumber.isEmpty || password.isEmpty || confirmPassword.isEmpty {
                                alertMessage = "الرجاء ملء جميع الحقول."
                                showAlert.toggle()
                            } else if password != confirmPassword {
                                alertMessage = "كلمة المرور غير متطابقة."
                                showAlert.toggle()
                            } else {
                                // استدعاء دالة CloudKitManager لحفظ البيانات
                                cloudKitManager.saveUser(userName: userName, password: password, phoneNumber: phoneNumber) { result in
                                    switch result {
                                    case .success(let successMessage):
                                        alertMessage = successMessage
                                        showAlert.toggle()
                                    case .failure(let error):
                                        alertMessage = "حدث خطأ أثناء حفظ البيانات: \(error.localizedDescription)"
                                        showAlert.toggle()
                                    }
                                }
                            }
                        }) {
                            Text("Create Account")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .frame(width: 160.0, height: 50.0)
                                .background(Color.ylw)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("النتيجة"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
                    }
                    .padding(.top, 10)

                    Spacer() // لإضافة مسافة في الأسفل
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .presentationDetents([.medium]) // التحكم في ارتفاع الشيت
        }
    }
}

