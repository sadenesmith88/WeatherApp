//
//  ContentView.swift
//  WeatherApp
//
//  Created by sade on 12/14/24.
//
import SwiftUI
struct ContentView: View {
    let cityName: String
    @State private var currentCity: String
    @State private var navigateToWeatherView: Bool = false // State for navigation
    @ObservedObject var viewModel: WeatherViewModel

  init(cityName: String, viewModel: WeatherViewModel) {
        // Load the saved city or use a default value
        let savedCity = UserDefaults.standard.string(forKey: "savedCity") ?? "DefaultCity"
        self._currentCity = State(initialValue: savedCity)
        self.viewModel = viewModel
        self.cityName = cityName
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 5) {
                // Search bar always visible
                SearchBar(text: $viewModel.searchText, onSearch: {
                    viewModel.searchCity(for: viewModel.searchText)
                })
                .padding(.horizontal)
                .padding(.bottom, 12)

                // Show CitySearchResultsCard if a search result exists
                if let searchResult = viewModel.searchResult {
                    CitySearchResultsCard(
                        city: searchResult.cityName,
                        temperature: searchResult.temperature,
                        iconURL: searchResult.iconURL
                    )
                    .padding(.horizontal)
                    .onTapGesture {
                        // Save the selected city and navigate
                        saveCityToUserDefaults(city: searchResult.cityName)
                        currentCity = searchResult.cityName
                        viewModel.fetchWeather(for: searchResult.cityName)
                        viewModel.searchResult = nil
                        navigateToWeatherView = true // Trigger navigation
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
                            feelsLike: weather.current.feelslike_c
                        )
                    }
                    .padding(.bottom, 40)
                } else if viewModel.isLoading {
                    ProgressView("Fetching weather...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    Text("Search Location")
                        .foregroundColor(.gray)
                        .padding()
                }

                Spacer()
            }
            .padding(.bottom, 16)
            .navigationDestination(isPresented: $navigateToWeatherView) {
              ContentView(cityName: cityName, viewModel: viewModel) // Reopen ContentView with updated city
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
}






