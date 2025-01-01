import SwiftUI

// نموذج المراجعة
struct Review: Identifiable {
    var id = UUID()
    let username: String
    let date: String
    let rating: Int
    let comment: String
}

// شاشة المراجعات
struct ReviewPage: View {
    @State private var userImages: [UIImage] = []
    let defaultImage = "Logo2"
    let reviews = [
        Review(username: "Ghada", date: "Sat, Aug 32, 2024", rating: 3, comment: "اعجبني"),
        Review(username: "Sadeem", date: "Sat, Aug 31, 2024", rating: 5, comment: "تقييم ممتاز")
    ]
    @State private var showAddSheet = false
    @State private var isLiked = false
    var body: some View {
        
    ZStack {
        Color.bg.ignoresSafeArea()

    VStack {
            // الشريط العلوي
    HStack {
        Button(action: {
            print("Back tapped")
                }) {
    HStack {
        Image(systemName: "chevron.backward")
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
            .foregroundColor(.white)
        Text("Review")
            .foregroundColor(.bg)
            .font(.title2)
            .bold()
            .padding(.leading, 110.0)
                            }
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
            .frame(height: 55)
            .padding()
            .background(
        LinearGradient(
            gradient: Gradient(stops: [
            .init(color: .blu4, location: -0.2),
            .init(color: .blu2, location: 0.50),
            .init(color: .blu1, location: 1.0)
                            ]),
            startPoint: .top,
            endPoint: .bottom
                        )
            .ignoresSafeArea()
                    )

        Spacer()

                    // محتوى التطبيق الرئيسي
    VStack(alignment: .leading) {
    VStack(alignment: .leading, spacing: 4) {
        TabView {
    if userImages.isEmpty {
        Image(defaultImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 150)
            .cornerRadius(10)
            .clipped()
            } else {
        ForEach(userImages, id: \.self) { image in
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 150)
            .cornerRadius(15)
            .clipped()
                                    }
                                }
                            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 150)
            .cornerRadius(15)

        Text("Wender Garden")
            .font(.title2)
            .fontWeight(.bold)
            .padding(.leading, 5.0)

        HStack{
            Text("Entertainment")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.leading, 5.0)
            Spacer()
            Button(action: {
                isLiked.toggle()
            }) {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height:40)
                    .foregroundColor(isLiked ? .red : .gray)
                
                
                    .padding(.trailing, 55)
            }
        }
        // المؤشرات يسار والتقييم والنجوم يمين
    HStack(alignment: .center, spacing: 20) {
                // المؤشرات
    VStack(alignment: .leading, spacing: 5) {
    HStack {
        Image(systemName: "toilet.fill")
            .foregroundColor(.gray)
        ProgressView(value: 0.4)
            .progressViewStyle(LinearProgressViewStyle(tint: .yellow))
        Text("40%")
            .font(.subheadline)
            .foregroundColor(.gray)
                                    }
    HStack {
        Image(systemName: "fork.knife")
            .foregroundColor(.gray)
        ProgressView(value: 0.8)
            .progressViewStyle(LinearProgressViewStyle(tint: .yellow))
        Text("80%")
            .font(.subheadline)
            .foregroundColor(.gray)
                                    }
    HStack {
        Image(systemName: "car.fill")
            .foregroundColor(.gray)
        ProgressView(value: 0.3)
            .progressViewStyle(LinearProgressViewStyle(tint: .yellow))
        Text("30%")
            .font(.subheadline)
            .foregroundColor(.gray)
                                    }
    }
    .padding([.leading, .bottom], 15.0)

            // التقييم والنجوم
    VStack {
        
        Text("4.6")
            .font(.title)
            .fontWeight(.bold)
    HStack(spacing: 2) {
        ForEach(0..<5) { index in
        Image(systemName: index < 4 ? "star.fill" : "star")
            .foregroundColor(index < 4 ? .yellow : .gray)
                                        }
                                    }
        
    }
    .padding(.bottom, 15.0)
            .frame(maxWidth: .infinity)
                            }
            .padding(.top, 10)

                        }
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 0)
            .padding()
                    }

        ScrollView {
    VStack(alignment: .leading, spacing: 10) {
        ForEach(reviews) { review in
    VStack(alignment: .leading, spacing: 5) {
    HStack {
        Text(review.username)
            .font(.subheadline)
        Spacer()
        Text(review.date)
            .font(.subheadline)
            .foregroundColor(.gray)
                                    }
    HStack(spacing: 2) {
        ForEach(0..<5) { index in
        Image(systemName: index < review.rating ? "star.fill" : "star")
            .foregroundColor(index < review.rating ? .yellow : .gray)
                                        }
                                    }
        Text(review.comment)
            .font(.body)
            .foregroundColor(.gray)
                                }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                            }

        
                        }
                .padding()
                    }
                .sheet(isPresented: $showAddSheet) {
             AddReviewSheet(userImages: $userImages)
                    }
        Divider()
        HStack{
            Text("Add review")
                .foregroundColor(.gray)
                .padding(.leading, 70.0)
            Spacer()
            Button(action: {
                showAddSheet = true
            }) {
               
                Text("+")
                    
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .frame(width: 60,height: 60)
                    .background(Color.ylw)
                    .foregroundColor(.white)
                    .cornerRadius(100)
                    .padding()
            }
            
            .frame(width: 150.0, height: 55.0)
            
            
            
        }
                }
                Spacer()
            }
        
        .accentColor(.circle)
        .background(Color.white)
    }
}

struct AddReviewSheet: View {
    @Binding var userImages: [UIImage]
    @Environment(\.dismiss) var dismiss
    @State private var selectedStars: [Int: Int] = [:]
    @State private var userNotes: String = ""
    @State private var isLiked: Bool = false
    var body: some View {
VStack(alignment: .leading, spacing: 20) {
                    // العنوان وزر الإعجاب
    HStack {
    VStack(alignment: .leading, spacing: 4) {
        Text("Wender Garden")
            .font(.title)
            .fontWeight(.bold)
                            
    HStack {
        Text("Entertainment")
            .foregroundColor(.gray)
                                
                Spacer()
                                
        Button(action: {
            isLiked.toggle()
                    }) {
        Image(systemName: isLiked ? "heart.fill" : "heart")
            .resizable()
            .frame(width: 36, height: 36)
                   
        // تكبير حجم زر اللايك
                        
            .foregroundColor(isLiked ? .red : .gray)
                                }
            .padding(.trailing, 40.0)
                            }
                        }
                    }
                    
        // التقييم العام
    
    VStack {
        Text("4.6")
            .font(.largeTitle)
            .fontWeight(.bold)
                        
    HStack(spacing: 4) {
        ForEach(0..<5) { index in
        Image(systemName: index < 4 ? "star.fill" : "star")
            .resizable()
            .frame(width: 30, height: 30)
            // تكبير النجوم
                                    .foregroundColor(index < 4 ? .yellow : .gray)
                            }
                        }
                        
                        Text("(2560)")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Divider()
                    
                    // تقييم النجوم الخاص بالمستخدم
                    Text("Your rating")
                        .font(.headline)
                    
                    ForEach(["Toilet", "Slides", "Parking"], id: \.self) { category in
                        HStack {
                            Image(systemName: category == "Toilet" ? "toilet.fill" :
                                    category == "Slides" ? "figure.playground" :
                                    "car.fill")
                                .foregroundColor(.gray)
                            
                            HStack {
                                ForEach(1...5, id: \.self) { star in
                                    Image(systemName: star <= (selectedStars[category.hashValue] ?? 0) ? "star.fill" : "star")
                                        .resizable()
                                        .frame(width: 24, height: 24) // تكبير حجم النجوم
                                        .foregroundColor(star <= (selectedStars[category.hashValue] ?? 0) ? .yellow : .gray)
                                        .onTapGesture {
                                            selectedStars[category.hashValue] = star
                                        }
                                }
                            }
                        }
                    }
                    
                    // مربع النص
                    Text("Your notes")
                        .font(.headline)
                    
                    TextField("Write your notes here...", text: $userNotes)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(height: 100) // تكبير مربع النص
                    
                    // زر Add Picture وزر Add
                    HStack {
                        Button(action: {
                            // منطق إضافة صورة
                        }) {
                            HStack {
                                Image(systemName: "photo.on.rectangle.angled")
                                    .foregroundColor(.ylw)
                                Text("Add Picture")
                                    .foregroundColor(.ylw)
                                
                            }
                            .padding()
                            .background(Color.yellow.opacity(0.2))
                            .cornerRadius(8)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // منطق زر Add
                        }) {
                            Text("Add")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: 100)
                                .background(Color.yellow)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                .presentationDetents([.fraction(0.9)]) // تحديد ارتفاع الـ sheet
    }
}

#Preview {
    ReviewPage()
}
