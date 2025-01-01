

//
//  MainScreen1.swift
//  kommal
//
//  Created by hailah alsaudi on 22/06/1446 AH.
//
import SwiftUI

struct MainScreen1: View {
    @State private var selectedCategory: String? = nil
    @State private var places: [Place] = Place.samplePlaces

    var body: some View {
        TabView {
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
                        NavigationLink(destination: FilterPage()) {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: Profile()) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44, height: 44)
                                .foregroundColor(.white)
                                .padding(.vertical, 10.0)
                        }
                    }
                    .padding()
                    .padding(.horizontal, 17)
                    .padding(.top, 10)
                    
                    HStack(spacing: 10) {
                        ForEach(["Coffee", "Restaurant", "Fun", "Other"], id: \.self) { category in
                            VStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(selectedCategory == category ? Color.blu1 : Color.bg)
                                    .frame(width: selectedCategory == category ? 140 : 62, height: selectedCategory == category ? 80 : 50)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(selectedCategory == category ? Color.ylw : Color.clear, lineWidth: 4)
                                    )
                                    .onTapGesture {
                                        withAnimation(.spring()) {
                                            selectedCategory = category
                                        }
                                    }
                                
                                Text(getCategoryName(category: category))
                                    .font(selectedCategory == category ? .headline : .caption)
                                    .foregroundColor(selectedCategory == category ? .blu1 : .white)
                                    .padding(.top, 15)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal, 16)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(places.filter { selectedCategory == nil || $0.category == selectedCategory }) { place in
                                PlaceCardView(place: place)
                                    .frame(width: 290, height: 450)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    Spacer()
                }
            }
            .tabItem {
                Image(systemName: "square.grid.2x2.fill")
                Text("Browse")
            }
            
            NavigationView {
                MapScreen()
            }
            .tabItem {
                Image(systemName: "mappin.and.ellipse")
                Text("Map")
            }
           
            
        }
        .accentColor(.circle)
        .navigationBarBackButtonHidden(true)
    }
    
    func getCategoryName(category: String) -> String {
        switch category {
        case "Coffee": return "Coffee"
        case "Restaurant": return "Restaurant"
        case "Fun": return "Fun"
        case "Other": return "Other"
        default: return category
        }
    }
}

//struct Place: Identifiable {
//    let id = UUID()
//    let name: String
//    let category: String
//    let rating: Double
//    let reviews: Int
//    let images: [String] // صورة واحدة أو أكثر
//
//    static let samplePlaces: [Place] = [
//        Place(name: "Pizza Palace", category: "Food", rating: 4.5, reviews: 120, images: ["pizza", "pizza2"]),
//        Place(name: "Sushi World", category: "Food", rating: 4.8, reviews: 95, images: ["sushi", "sushi2"]),
//        Place(name: "Gourmet Restaurant", category: "Restaurant", rating: 4.9, reviews: 210, images: ["gourmet", "gourmet2"]),
//        Place(name: "Fun Land", category: "Entertainment", rating: 4.7, reviews: 140, images: ["funland", "funland2"]),
//        Place(name: "Coffee Shop", category: "Coffee", rating: 4.2, reviews: 85, images: ["coffee", "coffee2"]),
//    ]
//}

struct PlaceCardView: View {
    let place: Place
    @State private var isLiked = false

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Color.gray.opacity(0.2) // لون خلفية للصورة
                if let firstImage = place.images.first {
                    Image(firstImage) // استخدام الصورة الأولى
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            // اسم المكان وقلب الإعجاب
            HStack {
                Text(place.name)
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Button(action: {
                    isLiked.toggle()
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .foregroundColor(isLiked ? .red : .gray)
                }
            }
            .padding(.horizontal)
            
            // النجوم والتقييم أسفل الاسم
            VStack(alignment: .leading) {
                HStack(spacing: 3) {
                    ForEach(0..<5) { index in
                        Image(systemName: index < Int(place.rating) ? "star.fill" : "star")
                            .foregroundColor(index < Int(place.rating) ? .yellow : .gray)
                    }
                    Spacer()
                        .padding([.top, .bottom, .trailing], 10)
                
                }
                Text("\(place.rating, specifier: "%.1f")")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }
            .padding(.horizontal)
            
            // زر إضافة تقييم
            HStack {
                Spacer()
                Button(action: {
                    print("إضافة تقييم للمكان: \(place.name)")
                }) {
                    Text("Review")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.trailing)
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .background(Color.ylw)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 15)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
        )
        //.shadow(radius: 4)
    }
}

#Preview {
    MainScreen1()
}



