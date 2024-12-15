//
//  SearchBar.swift
//  WeatherApp
//
//  Created by sade on 12/14/24.
//

import SwiftUI

struct SearchBar: View {
  @Binding var text: String
  var onSearch: () -> Void

    var body: some View {
      HStack {
        TextField("Search Location", text: $text, onCommit: onSearch)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .background(Color(.systemGray4))
          .padding(.leading, 4)

        Button(action: onSearch) {
          Image(systemName: "magnifyingglass")
        }
        .padding(.trailing, 8)
      }
      padding()
    }
}


