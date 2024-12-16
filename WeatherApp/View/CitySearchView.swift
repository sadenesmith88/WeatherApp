//
//  CitySearchView.swift
//  WeatherApp
//
//  Created by sade on 12/14/24.
//

import SwiftUI
import SwiftUI

struct CitySearchView: View {
    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        NavigationStack {
            VStack {
                // Search Bar
                SearchBar(
                    text: $viewModel.searchText,
                    onSearch: {
                        if !viewModel.searchText.isEmpty {
                            viewModel.searchCity(for: viewModel.searchText)
                        }
                    }
                )
                .padding(.horizontal)
                .padding(.top, 20)

                Spacer()

                // Display states based on ViewModel properties
                if viewModel.isLoading {
                    ProgressView("Searching...")
                        .padding()
                } else if let boldMessage = viewModel.boldErrorMessage,
                          let regularMessage = viewModel.regularErrorMessage {
                    // Display error messages with custom formatting
                    VStack(spacing: 8) {
                        Text(boldMessage)
                            .font(.custom("Poppins-Bold", size: 20))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.top, 20)

                        Text(regularMessage)
                            .font(.custom("Poppins-Bold", size: 15))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 150)
                } else if let searchResult = viewModel.searchResult {
                    NavigationLink(
                        destination: ContentView(
                            cityName: searchResult.cityName,
                            viewModel: viewModel
                        )
                    ) {
                        CitySearchResultsCard(
                            city: searchResult.cityName,
                            temperature: searchResult.temperature,
                            iconURL: searchResult.iconURL
                        )
                        .padding()
                    }
                } else if viewModel.searchText.isEmpty {
                    PlaceholderView(
                        title: "No City Selected",
                        message: "Please Search For A City"
                    )
                    .padding(.top, 150)
                } else {
                    PlaceholderView(
                        title: "No results found",
                        message: nil
                    )
                    .padding(.top, 150)
                }

                Spacer()
            }
            .navigationTitle("City Search")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true) // Optional: Hide the default back button
        }
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



