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
        HStack(spacing: 50) {
            // Humidity
            VStack {
                Text("Humidity")
                    .font(.custom("Poppins-Regular", size: 12)) // Title font
                    .foregroundColor(Color("foregroundGray"))
                Text("\(humidity)%")
                    .font(.custom("Poppins-Regular", size: 15)) // Value font
                    .foregroundColor(Color("weatherSpec"))
            }

            // UV
            VStack {
                Text("UV")
                    .font(.custom("Poppins-Regular", size: 12)) // Title font
                    .foregroundColor(Color("foregroundGray"))
                Text("\(uv, specifier: "%.0f")") // Rounded UV index
                    .font(.custom("Poppins-Regular", size: 15)) // Value font
                    .foregroundColor(Color("weatherSpec"))
            }

            // Feels Like
            VStack {
                Text("Feels Like")
                    .font(.custom("Poppins-Regular", size: 12)) // Title font
                    .foregroundColor(Color("foregroundGray"))
                Text("\(Int(round(feelsLike)))°") // Rounded Feels Like temperature
                    .font(.custom("Poppins-Regular", size: 15)) // Value font
                    .foregroundColor(Color("weatherSpec"))
            }
        }
        .padding()
        .frame(width: 274, height: 75)
        .background(Color("backgroundGray"))
        .cornerRadius(10)
    }
}



