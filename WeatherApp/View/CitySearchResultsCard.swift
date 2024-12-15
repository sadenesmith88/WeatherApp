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
      print("City: \(city), Temperature: \(temperature), iconURL: \(iconURL)")
      return HStack(spacing: 20) {
        //vstack for city name and temp
        VStack(alignment: .leading, spacing: 5) {
          Text(city)
            .font(.system(size: 20))
            .fontWeight(.bold)
            .foregroundColor(.black)

          Text("\(temperature, specifier: "%.1f")°")
            .font(.system(size: 60))
            .foregroundColor(.black)
        }
        Spacer()

        let validIconURL = iconURL.hasPrefix("http") ? iconURL : "https:" + iconURL
        if let url = URL(string: validIconURL) {
          //weather icon
          AsyncImage(url: url) { image in
            image
              .resizable()
              .scaledToFit()
          } placeholder: {
            ProgressView()
          }
          .frame(width: 83, height: 67)

        } else {
          Text("Invalid URL")
            .font(.footnote)
            .foregroundColor(.red)
            .frame(width: 100, height: 100)
        }
      }
      .padding(10)
      .background(Color("backgroundGray"))
      .cornerRadius(16)

    }
}


