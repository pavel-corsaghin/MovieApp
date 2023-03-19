//
//  MovieListView.swift
//  MovieApp
//
//  Created by HungNguyen on 2023/03/19.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var viewModel: MovieListViewModel
    @State var movieName = ""
    
    var body: some View {
        VStack {
            TextField("Search movie by name", text: $movieName)
                .onSubmit {
                    viewModel.searchMovies(movieName)
                }
                .submitLabel(.search)
                .frame(height: 50)
                .textFieldStyle(PlainTextFieldStyle())
                .padding([.horizontal], 12)
                .cornerRadius(16)
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.4)))
                .padding()
            
            if let error = viewModel.erroMessage {
                Text(error)
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }
                        
            ScrollView {
                VStack {
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ],
                        alignment: .center,
                        spacing: MovieCell.itemSpacing,
                        content: {
                            ForEach (viewModel.movies, id:\.imdbId) { movie in
                                MovieCell(movie: movie)
                                    .onAppear {
                                        viewModel.loadMoreIfNeed(movieName, movie)
                                    }
                            }
                        }
                    ).padding(.horizontal, MovieCell.horizontalPadding)
                }
                
                if viewModel.isLoading {
                    ProgressView()
                }
            }
        }
        .navigationTitle("Movies")
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(viewModel: MovieListViewModel())
    }
}

