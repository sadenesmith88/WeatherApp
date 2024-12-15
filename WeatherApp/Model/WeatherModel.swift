//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by sade on 12/14/24.
//

import Foundation

struct WeatherModel: Decodable {
  let location: Location
  let current: Current

  struct Location: Decodable {
    let name: String
    let region: String?
    let country: String
    let lat: Double?
    let lon: Double?
  }

  struct Current: Decodable {
    let temp_c: Double
    let temp_f: Double
    let feelslike_c: Double
    let feelslike_f: Double
    let humidity: Int
    let uv: Double
    let condition: Condition

    struct Condition: Decodable {
      let text: String
      let icon: String 
    }
  }
}
struct SearchResult: Decodable, Identifiable {
  let id = UUID()
  let cityName: String
  let temperature: Double
  let iconURL: String
}
