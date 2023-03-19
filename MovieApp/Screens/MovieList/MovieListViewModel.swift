//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by HungNguyen on 2023/03/19.
//

import Foundation
import Combine

final class MovieListViewModel: ObservableObject {
    
    // MARK: - Private Properties
    
    private let service: MovieServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private var totalResults = 0
    private var page = 1
    
    // MARK: - Public Properties

    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var erroMessage: String?

    // MARK: - Initializer

    init(service: MovieServiceProtocol = MovieService()) {
        self.service = service
    }
    
    // MARK: - Actions

    func searchMovies(_ name: String) {
        movies = []
        isLoading = true
        erroMessage = nil
        service.searchMovies(movie: name, page: 1)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self = self else {
                        return
                    }
                    
                    switch completion {
                    case .finished:
                        self.page = 1
                    case .failure(let error):
                        self.erroMessage = error.description
                    }
                    self.isLoading = false
                },
                receiveValue: { [weak self] response in
                    guard let self = self else {
                        return
                    }
                    
                    self.movies = response.movies
                    self.totalResults = response.totalResults
                    self.erroMessage = response.error
                }
            )
            .store(in: &cancellables)
    }
    
    func loadMoreIfNeed(_ name: String, _ movie: Movie) {
        guard !isLoading, // Already loading
              movies.count < totalResults, // No more items to load
              movies.last == movie // Only load when showing current last item
        else {
            return
        }
        
        isLoading = true
        service.searchMovies(movie: name, page: page + 1)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self = self else {
                        return
                    }
                    
                    switch completion {
                    case .finished:
                        self.page += 1
                    case .failure(let error):
                        // TODO: - Handle error
                        print(error.localizedDescription)
                    }
                    self.isLoading = false
                },
                receiveValue: { [weak self] response in
                    guard let self = self else {
                        return
                    }
                    
                    self.movies.append(contentsOf: response.movies)
                }
            )
            .store(in: &cancellables)
    }
}

extension Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.imdbId == rhs.imdbId
    }
}
