import SwiftUI

struct Profile: View {
    @Environment(\.dismiss) var dismiss //noteeeee
    // تعريف مصفوفة تحتوي على الأماكن المفضلة
    @State private var favoritePlaces = [
        ("Beach", "4.5", "photo"),  // مثال للمكان مع تقييمه وصورته
        ("Mountain", "5.0", "photo"),
        ("Park", "4.0", "photo"),
        ("Restaurant", "4.8", "photo")
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // خلفية التدرج اللوني
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: .blu4, location: 0.00),
                        .init(color: .blu2, location: 0.110),
                        .init(color: .blu2, location: 0.110),
                        .init(color: .bg, location: 0.40),
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack {
                    // صورة الشخص
                    Image(systemName: "person.circle.fill") // صورة افتراضية
                        .resizable()
                        .foregroundColor(Color.white)
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .padding(.top, 40)

                    // اسم الشخص
                    Text("John Doe")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.blu3)
                        .padding(.top, 10)

                    // خط يفصل بين البيانات وقائمة المفضلات
                    Divider()
                        .background(Color.white)
                        .padding(.vertical, 1)

                    // قائمة مفضلات الأماكن
                    VStack(alignment: .leading) {
                        Text("Favorite Places")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.blu3)
                            .padding([.top, .leading], 30)

                        // ScrollView بدلاً من List لجعل القائمة قابلة للتمرير
                        ScrollView {
                            VStack(spacing: 15) {
                                // إضافة الأماكن إلى الواجهة باستخدام HStack
                                ForEach(favoritePlaces, id: \.0) { place in
                                    HStack {
                                        Image(systemName: place.2) // صورة المكان (يمكنك استبدالها)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60)
                                            .cornerRadius(10)
                                        
                                        VStack(alignment: .leading) {
                                            Text(place.0)  // اسم المكان
                                                .fontWeight(.bold)
                                                .foregroundColor(.blu3)
                                            
                                            Text("Rating: \(place.1)")  // التقييم
                                                .foregroundColor(.gray)
                                        }
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            // منطق لتفضيل المكان عند الضغط على زر القلب
                                        }) {
                                            Image(systemName: "heart.fill")
                                                .foregroundColor(.red)
                                                .frame(width: 30.0, height: 30.0)
                                        }
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                }
                            }
                            .padding(.horizontal, 30)
                        }
                    }
                    
                    Spacer()
                }
            }
            .navigationBarItems(leading: Button(action: {
                dismiss()     /*note*/       }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                    .frame(width: 30.0, height: 30.0)
            })
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Profile()
}
