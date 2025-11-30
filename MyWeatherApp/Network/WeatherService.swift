//
//  HomeView.swift
//  MyWeatherApp
//
//  Created by Mudasir on 30/11/25.
//

import Foundation

class WeatherService {
    static let shared = WeatherService()
    
    func getWeather(for city: String) async throws -> WeatherResponse {
        let geoURL = API.geocodeURL(for: city)
        let geo: GeoResponse = try await fetch(geoURL)
        guard let place = geo.results?.first else {
            throw NSError(domain: "No location found for city: \(city)", code: 404)
        }
        let lat = place.latitude
        let lon = place.longitude
        
        // Fetch weather and daily forecast
        let forecastUrl = API.forecastURL(lat: lat, lon: lon)

        return try await fetch(forecastUrl)
    }
    
    private func fetch<T: Decodable>(_ urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        print("Status code:", http.statusCode)
        print("Response JSON:")
        print(String(data: data, encoding: .utf8) ?? "No data")
        if http.statusCode != 200 {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}

