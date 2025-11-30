//
//  HomeView.swift
//  MyWeatherApp
//
//  Created by Mudasir on 30/11/25.
//

import SwiftUI

struct WeatherCard: View {
    let weather: WeatherResponse

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: weather.icon)
                .font(.system(size: 70))

            Text("\(weather.temp, specifier: "%.1f")°C")
                .font(.system(size: 60, weight: .bold))

            Text(weather.weatherDescription)
                .opacity(0.8)

            HStack {
                Text("H: \(weather.highTemp, specifier: "%.0f")°")
                Text("L: \(weather.lowTemp, specifier: "%.0f")°")
            }
            .opacity(0.8)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.thinMaterial)
        .cornerRadius(20)
        .padding()
    }
}

