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
          .padding(.leading, 12)
          .foregroundColor(Color("searchColor"))
          .frame(height: 46)

        Button(action: onSearch) {
          Image(systemName: "magnifyingglass")
            .frame(width: 9, height: 9)
            .foregroundColor(Color("foregroundGray"))
            .padding(.trailing, 20)
           
        }
      }
      
      .frame(width: 327, height: 46)
      .background(Color("backgroundGray"))
      .cornerRadius(16)
      .padding(.top, 44)
      .padding(.leading, 10)

    }
}


