//
//  WeatherViewModel.swift
//  MyWeatherApp
//
//  Created by Mudasir on 30/11/25.
//

import Foundation
import Combine

@MainActor
class WeatherViewModel: ObservableObject {

    @Published var weather: WeatherResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var city: String = "Banglore"

    private let service = WeatherService()

    func loadWeather(city: String) async {
        isLoading = true
        errorMessage = nil
        do {
            weather = try await service.getWeather(for: city)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}


