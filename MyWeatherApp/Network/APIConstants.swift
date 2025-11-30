//
//  HomeView.swift
//  MyWeatherApp
//
//  Created by Mudasir on 30/11/25.
//

import Foundation

enum API {
    static func geocodeURL(for city: String) -> String {
        let trimmedCity = city.trimmingCharacters(in: .whitespacesAndNewlines)
        let encodedCity = trimmedCity.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? trimmedCity
        let geoURL = "https://geocoding-api.open-meteo.com/v1/search?name=\(encodedCity)"
        return geoURL
    }
    
    static func forecastURL(lat: Double, lon: Double) -> String {
        var components = URLComponents(string: "https://api.open-meteo.com/v1/forecast")!
        components.queryItems = [
            URLQueryItem(name: "latitude", value: "\(lat)"),
            URLQueryItem(name: "longitude", value: "\(lon)"),
            URLQueryItem(name: "current_weather", value: "true"),
            URLQueryItem(name: "daily", value: "temperature_2m_max,temperature_2m_min"),
            URLQueryItem(name: "timezone", value: "auto")
        ]
        let url = components.url!.absoluteString
        return url
    }
}
