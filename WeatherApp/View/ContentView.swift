//
//  ContentView.swift
//  WeatherApp
//
//  Created by sade on 12/14/24.
//
import SwiftUI

struct ContentView: View {
    @State private var currentCity: String
    @State private var navigateToWeatherView: Bool = false // State for navigation
    @ObservedObject var viewModel: WeatherViewModel
  let cityName: String

  init(cityName: String, viewModel: WeatherViewModel) {
        // Load the saved city or use a default value
        let savedCity = UserDefaults.standard.string(forKey: "savedCity") ?? "DefaultCity"
        self._currentCity = State(initialValue: savedCity)
      self.cityName = savedCity
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                // Search bar
                SearchBar(text: $viewModel.searchText, onSearch: {
                    if !viewModel.searchText.isEmpty {
                        viewModel.searchCity(for: viewModel.searchText)
                    }
                })
                .padding(.horizontal)
                .padding(.bottom, 12)

                // Handle different states
                if viewModel.isLoading {
                    ProgressView("Fetching weather...")
                        .padding()
                } else if let searchResult = viewModel.searchResult {
                    // Show search result card
                    CitySearchResultsCard(
                        city: searchResult.cityName,
                        temperature: searchResult.temperature,
                        iconURL: searchResult.iconURL
                    )
                    .padding(.horizontal)
                    .onTapGesture {
                        saveCityToUserDefaults(city: searchResult.cityName)
                        currentCity = searchResult.cityName
                        viewModel.fetchWeather(for: searchResult.cityName)
                        viewModel.searchResult = nil
                        navigateToWeatherView = true
                    }
                } else if let weather = viewModel.weather {
                    // Show weather details
                    VStack(spacing: 8) {
                        AsyncImage(url: URL(string: "https:\(weather.current.condition.icon)")) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 123, height: 113)
                        } placeholder: {
                            ProgressView()
                        }

                        HStack {
                            Text(weather.location.name)
                                .font(.custom("Poppins-Bold", size: 30))

                            if let lat = weather.location.lat, let lon = weather.location.lon {
                                Link(destination: URL(string: "https://maps.apple.com/?ll=\(lat),\(lon)")!) {
                                    Image(systemName: "location.north.fill")
                                        .rotationEffect(.degrees(40))
                                        .frame(width: 21, height: 21)
                                        .foregroundColor(.black)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                        .padding()

                        HStack(alignment: .center, spacing: 5) {
                            Text("\(Int(round(weather.current.temp_f)))")
                                .font(.custom("Poppins-Bold", size: 60))
                                .foregroundColor(.black)
                            Text("°")
                                .font(.custom("Poppins-Regular", size: 20))
                                .foregroundColor(.black)
                                .baselineOffset(30)
                        }

                        WeatherSpecifiersCard(
                            humidity: weather.current.humidity,
                            uv: weather.current.uv,
                            feelsLike: Double(Int(weather.current.feelslike_f))
                        )
                    }
                    .padding(.bottom, 40)
                } else if let boldMessage = viewModel.boldErrorMessage,
                          let regularMessage = viewModel.regularErrorMessage {
                    
                      VStack(spacing: 8) {
                                             Text(boldMessage)
                                                 .font(.custom("Poppins-Bold", size: 20))
                                                 .foregroundColor(.black)
                                                 .multilineTextAlignment(.center)

                                             Text(regularMessage)
                                                 .font(.custom("Poppins-Bold", size: 15))
                                                 .foregroundColor(.black)
                                                 .multilineTextAlignment(.center)
                                         }
                      .padding(.top, 50)
                } else {
                    PlaceholderView(
                        title: "No City Selected",
                        message: "Please Search For A City"
                    )
                    .padding()
                }

                Spacer()
            }
            .padding(.bottom, 16)
            .navigationDestination(isPresented: $navigateToWeatherView) {
              ContentView(cityName: currentCity, viewModel: viewModel) // Avoid recursive init
            }
            .onAppear {
                if viewModel.weather == nil {
                    viewModel.fetchWeather(for: currentCity)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }

    // Save selected city to UserDefaults
    private func saveCityToUserDefaults(city: String) {
        UserDefaults.standard.set(city, forKey: "savedCity")
    }

    // MARK: - PlaceholderView
    struct PlaceholderView: View {
        let title: String
        let message: String?

        var body: some View {
            VStack(spacing: 8) {
                Text(title)
                    .font(.custom("Poppins-Bold", size: 30))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()

                if let message = message {
                    Text(message)
                        .font(.custom("Poppins-Regular", size: 15))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
}






