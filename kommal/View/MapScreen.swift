//
//  MapScreen.swift
//  kommal
//
//  Created by Ghada al ajmi on 14/06/1446 AH.
//
import SwiftUI
import MapKit



// View
struct MapScreen: View {
    @StateObject private var viewModel = MapViewModel() // استخدام ViewModel
    
    @State private var isSheetPresented = false // لعرض الشيت
    @State private var isSearchActive = false // لتحديد ما إذا كان المستخدم في وضع البحث
    
    var body: some View {
        // TabView container to hold multiple tabs
     
         
                       
            // أول تبويب: شاشة الخريطة
            ZStack {
                VStack(spacing: 0) {
                    // Map view
                    VStack {
                        Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.searchResults) { item in
                           
                            MapAnnotation(coordinate: item.coordinate) {
                                Image(systemName: "mappin")
                                    .foregroundColor(.circle)
                                    .font(.title)
                            }
                        }
                        .edgesIgnoringSafeArea(.top)
                        .onAppear {
                            CLLocationManager().requestWhenInUseAuthorization()
                        }
                    }
                }
                
                // زر "+" لفتح الشيت
                Button(action: {
                    isSheetPresented.toggle() // عرض الشيت عند الضغط على الزر
                }) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color.white)
                        .offset(x: 0)
                }
                .frame(width: 72, height: 72)
                .fontWeight(.bold)
                .background(Circle())
                .foregroundColor(Color.ylw) // استخدام اللون الأصفر الصحيح
                .padding()
                .offset(x: 140, y: -300)
                .shadow(radius: 1)
                .sheet(isPresented: $isSheetPresented) {
                    // الشيت لبحث الأماكن
                    VStack {
                        TextField("ابحث عن مكان", text: $viewModel.searchQuery)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding([.leading, .trailing], 20)
                        
                        Button("بحث") {
                            viewModel.searchForPlaces(query: viewModel.searchQuery) // تنفيذ البحث
                            isSearchActive = true // تفعيل البحث
                            isSheetPresented = false // إغلاق الشيت بعد البحث
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.bottom, 20)
                        
                        // إذا لم توجد نتائج للبحث
                        if viewModel.searchResults.isEmpty && isSearchActive {
                            Text("لا توجد نتائج للبحث.")
                                .padding()
                                .foregroundColor(.red)
                        }
                    }
                    .padding()
                    .presentationDetents([.medium, .large]) // تحديد الشيت ليكون إما medium أو large
                    .presentationDragIndicator(.visible) // لعرض مؤشر السحب
                }
            }
                    .accentColor(.circle)
                    .background(Color.white)  // تعيين خلفية التبويبات
    }
}

struct MapScreen_Previews: PreviewProvider {
    static var previews: some View {
        MapScreen()
    }
}
