//
//  CitySearchView.swift
//  WeatherApp
//
//  Created by sade on 12/14/24.
//

import SwiftUI

struct CitySearchView: View {
  @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
      NavigationStack {
        VStack {
          //Search Bar
          TextField("Search Location", text: $viewModel.searchText)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .onSubmit {
              viewModel.searchCity(for: viewModel.searchText)
            }

          //search results card
          if let searchResult = viewModel.searchResult {
            NavigationLink(destination: ContentView(cityName: searchResult.cityName, viewModel: viewModel)) {
              CitySearchResultsCard(
                city: searchResult.cityName,
                temperature: searchResult.temperature,
                iconURL: searchResult.iconURL
              )
              .padding(.horizontal)
            }
          } else if viewModel.searchText.isEmpty {
            Text("Search Location")
              .foregroundColor(.gray)
              .padding()
          } else {
            Text("No results found")
              .foregroundColor(.gray)
              .padding()
          }
          Spacer()
        }

      }
    }
}

