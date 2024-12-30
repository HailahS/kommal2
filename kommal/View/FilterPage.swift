//
//  FilterPage.swift
//  kommal
//
//  Created by hailah alsaudi on 29/06/1446 AH.
//

import SwiftUI

struct FilterPage: View {
    @State private var searchText: String = "" // For search bar
    @State private var favorites: [UUID] = [] // To track favorite items
    @State private var selectedFilter: FilterOption = .all // Selected filter

    // Enum for filter options
    enum FilterOption: String, CaseIterable, Identifiable {
        case all = "All"
        case highReviews = "High Reviews (4-5)"
        case lowReviews = "Low Reviews (3-0)"
        case nearby = "Nearby"
        case farAway = "Far Away"

        var id: String { rawValue }
    }

    // Sample data for places
    let places: [PlaceOne] = [
        PlaceOne(image: "Bujiri f img", title: "Bujiri Terrace", rating: 4.2, reviews: 250, distance: 1.2),
        PlaceOne(image: "Wender f img", title: "Wender Garden", rating: 4.6, reviews: 2560, distance: 3.4),
        PlaceOne(image: "boly", title: "Boulevard World", rating: 4.8, reviews: 1268, distance: 0.8),
        PlaceOne(image: "The Groves f img", title: "The Groves Market", rating: 2.9, reviews: 2450, distance: 5.0)
    ]

    var body: some View {
       
            ZStack {
                Color.bg.ignoresSafeArea()

                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Button(action: {
                            
                        }) {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
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
                        }
                    }
                    .frame(height: 45)
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: .blu4, location: -0.2),
                                .init(color: .blu2, location: 0.5),
                                .init(color: .blu1, location: 1.0)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ).ignoresSafeArea()
                    )

                    // Search Bar with Microphone Inside
                    HStack {
                        HStack {
                            TextField("Search", text: $searchText)
                                .padding(.leading, 8)
                                .frame(height: 50)

                            Button(action: {
                                print("Microphone tapped")
                            }) {
                                Image(systemName: "mic.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 2)
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 8)

                    // Filter Dropdown
                    HStack {
                        Spacer()
                        Picker("Filter", selection: $selectedFilter) {
                            ForEach(FilterOption.allCases) { filter in
                                Text(filter.rawValue).tag(filter)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 2)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 8)

                    // List of Places
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(filteredPlaces) { place in
                                PlaceRow(
                                    place: place,
                                    isFavorite: favorites.contains(place.id),
                                    toggleFavorite: {
                                        toggleFavorite(for: place)
                                    }
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }.navigationBarBackButtonHidden(true)// Apply circle color for selected tab
    }

    // Filtered places based on search text and selected filter
    var filteredPlaces: [PlaceOne] {
        var filtered = places

        // Filter based on selected filter
        switch selectedFilter {
        case .highReviews:
            filtered = filtered.filter { $0.rating >= 4.0 }
        case .lowReviews:
            filtered = filtered.filter { $0.rating < 3.0 }
        case .nearby:
            filtered = filtered.sorted { $0.distance < $1.distance }
        case .farAway:
            filtered = filtered.sorted { $0.distance > $1.distance }
        case .all:
            break
        }

        // Filter based on search text
        if !searchText.isEmpty {
            filtered = filtered.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }

        return filtered
    }

    // Toggle favorite status
    private func toggleFavorite(for place: PlaceOne) {
        if let index = favorites.firstIndex(of: place.id) {
            favorites.remove(at: index) // Remove from favorites
        } else {
            favorites.append(place.id) // Add to favorites
        }
    }
}

// MARK: - Place Model
struct PlaceOne: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let rating: Double
    let reviews: Int
    let distance: Double // Distance in kilometers
}

// MARK: - PlaceRow
struct PlaceRow: View {
    let place: PlaceOne
    let isFavorite: Bool
    let toggleFavorite: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 16) {
                // Place Image
                Image(place.image)
                    .resizable()
                    .frame(width: 90, height: 90)
                    .cornerRadius(5)

                VStack(alignment: .leading, spacing: 8) {
                    // Title
                    Text(place.title)
                        .font(.headline)

                    // Stars and Reviews
                    HStack {
                        // Stars
                        HStack(spacing: 2) {
                            ForEach(1...5, id: \.self) { star in
                                Image(systemName: star <= Int(place.rating) ? "star.fill" : "star")
                                    .foregroundColor(star <= Int(place.rating) ? .yellow : .gray)
                                    .font(.system(size: 14))
                            }
                        }

                        // Reviews Count
                        Text("(\(place.reviews))")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    // Overall Rating
                    Text(String(format: "%.1f", place.rating))
                        .font(.title3)
                        .bold()
                        .foregroundColor(.black)
                }
                Spacer()

                // Favorite Button
                Button(action: toggleFavorite) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .red : .gray)
                        .font(.system(size: 24))
                }
            }

            // Review Button
            HStack {
                Spacer()
                Button(action: {
                    print("Review button tapped")
                }) {
                    Text("Review")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.yellow)
                        .cornerRadius(8)
                }
            }
            .padding([.horizontal, .bottom], -10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.2), radius: 3, x: 0, y: 3)
    }
}

// MARK: - Preview
struct FilterPage_Previews: PreviewProvider {
    static var previews: some View {
        FilterPage()
    }
}
