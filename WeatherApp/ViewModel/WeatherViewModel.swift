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
    @Published var boldErrorMessage: String? // First line of the error
    @Published var regularErrorMessage: String? // Second line of the error

    private let weatherService: WeatherServiceProtocol

    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }

    func fetchWeather(for city: String) {
        // Validate input
        guard !city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            updateErrorMessages(bold: "Please enter a valid city name.", regular: "Try again.")
            self.weather = nil
            return
        }

        // Reset states
        isLoading = true
        resetErrorMessages()
        weather = nil

        // Fetch weather data
        weatherService.fetchWeather(for: city) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let weather):
                    self?.weather = weather
                    self?.resetErrorMessages()
                    self?.searchText = "" // Clear search text
                case .failure(let error):
                    print("Error fetching weather: \(error.localizedDescription)")
                    self?.updateErrorMessages(bold: "No City Selected.", regular: "Please Search For A City.")
                    self?.weather = nil
                }
            }
        }
    }

    func searchCity(for query: String) {
        // Validate input
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            updateErrorMessages(bold: "Search query cannot be empty.", regular: "Please enter a city name.")
            self.searchResult = nil
            return
        }

        // Reset states
        isLoading = true
        resetErrorMessages()
        searchResult = nil

        // Fetch weather data for search
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
                    self?.resetErrorMessages()
                case .failure(let error):
                    print("Error searching city: \(error.localizedDescription)")
                    self?.updateErrorMessages(bold: "No City Selected", regular: "Please Search For A City")
                    self?.searchResult = nil
                }
            }
        }
    }

    private func updateErrorMessages(bold: String, regular: String) {
        self.boldErrorMessage = bold
        self.regularErrorMessage = regular
    }

    private func resetErrorMessages() {
        self.boldErrorMessage = nil
        self.regularErrorMessage = nil
    }

    private func correctURL(_ url: String) -> String {
        return url.hasPrefix("http") ? url : "https:" + url
    }
}

