import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    @Published var searchQuery = "" // استعلام البحث
    @Published var searchResults: [MapLocation] = [] // نتائج البحث
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 24.7136, longitude: 46.6753), // الرياض
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    ) // المنطقة الافتراضية للخريطة
    
    // دالة البحث عن الأماكن باستخدام MKLocalSearch
    func searchForPlaces(query: String) {
        guard !query.isEmpty else { return } // التأكد من وجود نص في الاستعلام
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = region
        
        let search = MKLocalSearch(request: request)
        
        // بدء البحث
        search.start { response, error in
            if let error = error {
                print("خطأ في البحث: \(error.localizedDescription)")
                return
            }
            
            if let response = response {
                // تحويل MapItems إلى MapLocation
                self.searchResults = response.mapItems.map { item in
                    MapLocation(id: item.hash, coordinate: item.placemark.coordinate)
                }
            }
        }
    }
}
