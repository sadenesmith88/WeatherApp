//
//  WeatherServiceProtocol.swift
//  WeatherApp
//
//  Created by sade on 12/14/24.
//

import Foundation

protocol WeatherServiceProtocol {
  func fetchWeather(for city: String, completion: @escaping (Result<WeatherModel, Error>) -> Void)
}

class WeatherService: WeatherServiceProtocol {
  private let baseUrl = "https://api.weatherapi.com/v1/current.json"
  private let apiKey = "6bb759cb16e94eaea97171310241412"

  func fetchWeather(for city: String, completion: @escaping (Result<WeatherModel, any Error>) -> Void) {
    let urlString = "\(baseUrl)?key=\(apiKey)&q=\(city)"
    guard let url = URL(string: urlString) else {
      completion(.failure(URLError(.badURL)))
      return
    }

    URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }

      guard let data = data else {
        completion(.failure(URLError(.badServerResponse)))
        return
      }

      //print raw json response to console
      print(String(data: data, encoding: .utf8) ?? "No data")

      do {
        let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
        completion(.success(weather))
      } catch {
        completion(.failure(error))
      }
    }.resume()
  }
}
