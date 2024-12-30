//
//  Place.swift
//  kommal
//
//  Created by hailah alsaudi on 29/06/1446 AH.
//
import Foundation

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let rating: Double
    let reviews: Int
    let images: [String] // صورة واحدة أو أكثر

    static let samplePlaces: [Place] = [
        Place(name: "Pizza Palace", category: "Food", rating: 4.5, reviews: 120, images: ["pizza", "pizza2"]),
        Place(name: "Sushi World", category: "Food", rating: 4.8, reviews: 95, images: ["sushi", "sushi2"]),
        Place(name: "Gourmet Restaurant", category: "Restaurant", rating: 4.9, reviews: 210, images: ["gourmet", "gourmet2"]),
        Place(name: "Fun Land", category: "Entertainment", rating: 4.7, reviews: 140, images: ["funland", "funland2"]),
        Place(name: "Coffee Shop", category: "Coffee", rating: 4.2, reviews: 85, images: ["coffee", "coffee2"]),
    ]
}
