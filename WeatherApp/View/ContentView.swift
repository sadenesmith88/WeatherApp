//
//  ContentView.swift
//  WeatherApp
//
//  Created by sade on 12/14/24.
//

import SwiftUI

struct ContentView: View {
  let cityName: String
  @ObservedObject  var viewModel: WeatherViewModel

  init(cityName: String, viewModel: WeatherViewModel) {
    self.cityName = cityName
    self.viewModel = viewModel
  }

    var body: some View {
        VStack {
          if viewModel.isLoading {
            ProgressView("Fetching weather...")
          } else if let weather = viewModel.weather {

            //icon
            AsyncImage(url:URL(string: "https:\(weather.current.condition.icon)")) { image in
              image.resizable().scaledToFit()
            } placeholder: {
              ProgressView()
            }
            .frame(width: 80, height: 80)

            HStack {
              Text(weather.location.name)
                .font(.largeTitle)
                .fontWeight(.bold)
              Spacer()

              //navigate to apple maps
              if let lat = weather.location.lat, let lon = weather.location.lon {
                Link(destination: URL(string: "https://maps.apple.com/?ll=\(lat),\(lon)")!) {
                  Image(systemName: "location.north.line")
                    .foregroundColor(.black)
                }
                .buttonStyle(BorderlessButtonStyle())
              }
            }
            .padding()

            //temperature
            Text("\(weather.current.temp_c, specifier: "%.1f")°C")
              .font(.system(size: 60))
              .fontWeight(.bold)

            //weather specifiers
            WeatherSpecifiersCard(humidity: weather.current.humidity,
                                  uv: weather.current.uv,
                                  feelsLike: weather.current.feelslike_c
            )
          }
            else if let errorMessage = viewModel.errorMessage {
              Text(errorMessage)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding()
            } else {
              Text("Loading weather data...")
                .foregroundColor(.gray)
            }
          }
        .padding()
        .onAppear {
          viewModel.fetchWeather(for: cityName)
        }
        }
    }


