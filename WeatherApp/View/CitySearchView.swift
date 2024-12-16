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
                // Search Bar
                SearchBar(text: $viewModel.searchText, onSearch: {
                    if !viewModel.searchText.isEmpty {
                        viewModel.searchCity(for: viewModel.searchText)
                    }
                })
                .padding(.horizontal)
                .padding(.top, 20)

                // Check for various states
                if viewModel.isLoading {
                    ProgressView("Searching...")
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Text("No City Selected")
                            .font(.custom("Poppins-Bold", size: 30))
                            .padding()

                        Text(errorMessage)
                            .font(.custom("Poppins-Bold", size: 15))
                            .foregroundColor(.black)
                    }
                    .padding(.top, 60)
                } else if let searchResult = viewModel.searchResult {
                    NavigationLink(destination: ContentView(cityName: searchResult.cityName, viewModel: viewModel)) {
                        CitySearchResultsCard(
                            city: searchResult.cityName,
                            temperature: searchResult.temperature,
                            iconURL: searchResult.iconURL
                        )
                        .padding()
                    }
                } else if viewModel.searchText.isEmpty {
                    VStack {
                        Text("No City Selected")
                            .font(.custom("Poppins-Bold", size: 30))
                            .padding()

                        Text("Please Search For A City")
                            .font(.custom("Poppins-Bold", size: 15))
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 60)
                } else {
                    VStack {
                        Text("No results found")
                            .font(.custom("Poppins-Regular", size: 15))
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 60)
                }

                Spacer()
            }
        }
    }
}





