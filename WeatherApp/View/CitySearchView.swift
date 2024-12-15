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
        SearchBar(text: $viewModel.searchText, onSearch: {
          viewModel.searchCity(for: viewModel.searchText)
        
        })
        //          .frame(maxWidth: .infinity)
        .padding(.horizontal)

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
          VStack {
            Text("No City Selected")
              .font(.system(size: 30))
              .fontWeight(.black)
            Text("Please Search For A City")
              .font(.system(size: 15))
              .foregroundColor(.black)
              .fontWeight(.black)
          }
          .padding(.top, 330)
        }
        else {
          Text("No results found")
            .foregroundColor(.gray)
            .padding()
        }
        Spacer()
      }

    }
  }
}


