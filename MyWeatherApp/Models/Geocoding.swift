//
//  HomeView.swift
//  MyWeatherApp
//
//  Created by Mudasir on 29/11/25.
//

import Foundation

// MARK: - Geocoding
struct GeoResponse: Codable {
    let results: [GeoResult]?
}

struct GeoResult: Codable {
    let name: String
    let latitude: Double
    let longitude: Double
}
