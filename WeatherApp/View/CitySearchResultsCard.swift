//
//  CitySearchResultsCard.swift
//  WeatherApp
//
//  Created by sade on 12/14/24.
//

import SwiftUI

struct CitySearchResultsCard: View {
  var city: String
  var temperature: Double
  var iconURL: String

    var body: some View {
      HStack(spacing: 20) {
        //vstack for city name and temp
        VStack(alignment: .leading, spacing: 5) {
          Text(city)
            .font(.headline)
            .fontWeight(.bold)

          Text("\(temperature, specifier: "%.1f")°C")
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        Spacer()

        //weather icon
        AsyncImage(url: URL(string: iconURL)) { image in
          image.resizable().scaledToFit()
        } placeholder: {
          ProgressView()
        }
        .frame(width: 50, height: 50)
      }
      .padding()
      .background(Color(.systemGray6))
      .cornerRadius(10)
      .shadow(radius: 5)
    }
}


