//
//  HomeView.swift
//  MyWeatherApp
//
//  Created by Mudasir on 29/11/25.
//

import Foundation

// MARK: - Weather Response
struct WeatherResponse: Codable {
    let latitude: Double
    let longitude: Double
    let currentWeather: CurrentWeather
    let daily: DailyWeather?
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case currentWeather = "current_weather"
        case daily
    }
}

struct DailyWeather: Codable {
    let temperature_2m_max: [Double]
    let temperature_2m_min: [Double]
    let time: [String]
}

extension WeatherResponse {
    // Current temperature
    var temp: Double { currentWeather.temperature }
    
    // High temperature
    var highTemp: Double {
        daily?.temperature_2m_max.first ?? currentWeather.temperature
    }
    
    // Low temperature
    var lowTemp: Double {
        daily?.temperature_2m_min.first ?? currentWeather.temperature
    }
    
    // Weather description from code
    var weatherDescription: String {
        WeatherCodeMapper.description(for: currentWeather.weathercode)
    }
    
    // SF Symbol icon
    var icon: String {
        WeatherCodeMapper.icon(for: currentWeather.weathercode)
    }
}

struct WeatherCodeMapper {
    
    static func icon(for code: Int) -> String {
        switch code {
            case 0: return "sun.max.fill"
            case 1, 2: return "cloud.sun.fill"
            case 3: return "cloud.fill"
            case 45, 48: return "cloud.fog.fill"
            case 51, 53, 55: return "cloud.drizzle.fill"
            case 61, 63, 65: return "cloud.rain.fill"
            case 71, 73, 75: return "snow"
            case 95: return "cloud.bolt.rain.fill"
            default: return "cloud"
        }
    }
    
    static func description(for code: Int) -> String {
        switch code {
            case 0: return "Clear Sky"
            case 1, 2: return "Partly Cloudy"
            case 3: return "Cloudy"
            case 45, 48: return "Foggy"
            case 51, 53, 55: return "Drizzle"
            case 61, 63, 65: return "Rain"
            case 71, 73, 75: return "Snow"
            case 95: return "Thunderstorm"
            default: return "Unknown"
        }
    }
}

// MARK: - CurrentWeather
struct CurrentWeather: Codable {
    let temperature: Double
    let windspeed: Double
    let winddirection: Double
    let weathercode: Int
    let time: String
}

// MARK: - CurrentWeather extensions
extension CurrentWeather {
    var weatherDescription: String {
        switch weathercode {
            case 0: return "Clear"
            case 1, 2, 3: return "Partly Cloudy"
            case 45, 48: return "Foggy"
            case 51, 53, 55: return "Drizzle"
            case 61, 63, 65: return "Rain"
            case 71, 73, 75: return "Snow"
            case 95: return "Thunderstorm"
            default: return "Unknown"
        }
    }

    var icon: String {
        switch weathercode {
            case 0: return "sun.max.fill"
            case 1, 2, 3: return "cloud.sun.fill"
            case 45, 48: return "cloud.fog.fill"
            case 51, 53, 55: return "cloud.drizzle.fill"
            case 61, 63, 65: return "cloud.rain.fill"
            case 71, 73, 75: return "snow"
            case 95: return "cloud.bolt.fill"
            default: return "questionmark.circle.fill"
        }
    }
}
