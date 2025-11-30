//
//  HomeView.swift
//  MyWeatherApp
//
//  Created by Mudasir on 29/11/25.
//

import SwiftUI

struct HomeView: View {

    @StateObject var viewModel = WeatherViewModel()

    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 20) {

                // Search bar
                HStack {
                    TextField("Enter city name", text: $viewModel.city)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)

                    Button("Search") {
                        Task { await viewModel.loadWeather(city: viewModel.city) }
                    }
                    .buttonStyle(.borderedProminent)
                }

                Spacer()

                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .tint(.white)
                }
                else if let weather = viewModel.weather {
                    WeatherCard(weather: weather)
                }
                else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.white)
                }

                Spacer()
            }
            .padding(.top, 40)
        }
        .task {
            // Load default city first time
            await viewModel.loadWeather(city: viewModel.city)
        }
    }
}

#Preview {
    HomeView()
}
