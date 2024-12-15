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
      self.errorMessage = "PLease enter a valid city name"
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
        case .failure(let error):
          self?.errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
          print("Error: \(error)")
        }
      }
    }
  }

  func searchCity(for query: String) {
    guard !query.isEmpty else { return }

    //simulate search result for demonstration
    self.searchResult = SearchResult(
      cityName: query,
      temperature: 20.0,
      iconURL: "https://cdn.weatherapi.com/weather/64x64/day/113.png")
  }
}
