//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by sade on 12/14/24.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherModel?
    @Published var searchResult: SearchResult?
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let weatherService: WeatherServiceProtocol

    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }

    func fetchWeather(for city: String) {
        guard !city.isEmpty else {
            self.errorMessage = "Please enter a valid city name"
            return
        }

        isLoading = true
        weatherService.fetchWeather(for: city) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let weather):
                    self?.weather = weather
                    self?.errorMessage = nil
                    self?.searchText = "" // Clear search bar after successful fetch
                case .failure:
                    self?.errorMessage = "Failed to fetch weather. Please try again."
                    self?.weather = nil // Reset weather data if fetch fails
                }
            }
        }
    }

    func loadSavedCity() -> String {
        return UserDefaults.standard.string(forKey: "savedCity") ?? "DefaultCity"
    }

    func searchCity(for query: String) {
        guard !query.isEmpty else {
            self.errorMessage = "Search query cannot be empty"
            self.searchResult = nil // Clear previous results
            return
        }

        isLoading = true
        weatherService.fetchWeather(for: query) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let weather):
                    self?.searchResult = SearchResult(
                        cityName: weather.location.name,
                        temperature: weather.current.temp_f,
                        iconURL: self?.correctURL(weather.current.condition.icon) ?? ""
                    )
                    self?.errorMessage = nil // Clear error message
                case .failure:
                    self?.errorMessage = "No City Found. Please try a different search."
                    self?.searchResult = nil // Clear previous results
                }
            }
        }
    }

    private func correctURL(_ url: String) -> String {
        return url.hasPrefix("http") ? url : "https:" + url
    }
}
