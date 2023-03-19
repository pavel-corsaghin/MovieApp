//
//  ContentView.swift
//  MovieApp
//
//  Created by HungNguyen on 2023/03/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            MovieListView(viewModel: MovieListViewModel())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
