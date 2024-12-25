//
//  MapModel.swift
//  kommal
//

//


//  kommal
//

//
import uuid
import Foundation
import MapKit

// تعريف MapLocation
struct MapLocation: Identifiable {
    var id: Int // يمكن استخدام hash أو UUID أو أي معرف فريد آخر
    var coordinate: CLLocationCoordinate2D
}
