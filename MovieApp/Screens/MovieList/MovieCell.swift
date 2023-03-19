//
//  MovieCell.swift
//  MovieApp
//
//  Created by HungNguyen on 2023/03/19.
//

import SwiftUI

extension MovieCell {
    static let itemSpacing: CGFloat = 10
    static let horizontalPadding: CGFloat = 16
    static let numberOfRows: CGFloat = 2
    static let cellWidth: CGFloat = (UIScreen.main.bounds.width - 2 * horizontalPadding - (numberOfRows - 1) * itemSpacing) / 2
}

struct MovieCell: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            AsyncImage(
                url: URL(string: movie.poster),
                content: { image in
                    image.resizable()
                        .frame(width: MovieCell.cellWidth, height: MovieCell.cellWidth)
                },
                placeholder: {
                    Image("Placeholder")
                        .resizable()
                        .frame(width: MovieCell.cellWidth, height: MovieCell.cellWidth)
                }
            )
            Text(movie.title)
                .font(.headline)
                .lineLimit(2)
            Text(movie.year)
                .font(.body)
                .lineLimit(1)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color("CellBackground"))
        .cornerRadius(18.0)
    }
}


