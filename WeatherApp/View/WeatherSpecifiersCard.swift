//
//  WeatherSpecifiers.swift
//  WeatherApp
//
//  Created by sade on 12/14/24.
//

import SwiftUI

struct WeatherSpecifiersCard: View {
  var humidity: Int
  var uv: Double
  var feelsLike: Double

    var body: some View {
      HStack(spacing: 20) {
        VStack {
          Text("Humidity")
            .font(.headline)
            .foregroundColor(.gray)
          Text("\(humidity)%")
            .font(.caption)
            .fontWeight(.bold)
        }

        VStack {
          Text("UV")
            .font(.headline)
            .foregroundColor(.gray)
          Text("\(uv, specifier: "%.1f")")
            .font(.caption)
            .fontWeight(.bold)

        }
        VStack {
          Text("Feels Like")
            .font(.headline)
            .foregroundColor(.gray)
          Text("\(feelsLike, specifier: "%.1f")°")
            .font(.caption)
            .fontWeight(.bold)
        }
      }
      .padding()
      .frame(width: 274, height: 75)
      .background(Color("backgroundGray"))
      .cornerRadius(10)
      .shadow(radius: 5)
    }
}


