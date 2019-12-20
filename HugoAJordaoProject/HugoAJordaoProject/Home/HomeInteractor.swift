//
//  HomeInteractor.swift
//  HugoAJordaoProject
//
//  Created by Hugo Abolis Jordão on 17/12/19.
//  Copyright © 2019 Hugo Abolis Jordão. All rights reserved.
//

import Foundation
import UIKit

class HomeInteractor {
    var movieList: [MovieModel.ViewModel] = []
    var worker: HomeWorker?
    
    init(worker: HomeWorker? = HomeWorker()) {
        self.worker = worker
    }
    
    func getMovies(completion: @escaping( () -> ())) {
        worker?.getMovieList { response in
            if let responseMovie = response?.results {
                var count = 0
                for item in responseMovie {
                    let movie = MovieModel.ViewModel(movie: item)
                    let i = self.movieList.count
                    self.movieList.insert(movie, at: i)
                    if let imageUrl = movie.movie?.poster_path {
                        self.worker?.getImage(url: imageUrl, backupUrls: movie.movie?.backdrop_path, completion: { image, hasCover in
                            self.movieList[i].hasCover = hasCover
                            self.movieList[i].coverImage = image
                            count += 1
                            if count == self.movieList.count {
                                completion()
                            }
                        })
                    }
                }
            }
        }
    }
    
    func getMovieCell(index: Int, cell: MovieCollectionViewCell) -> MovieCollectionViewCell {
        let item = movieList[index]
        let receivedTitle = item.movie?.title ?? ""
        let fullTitle = receivedTitle.components(separatedBy: ":")
        let title = fullTitle.count > 1 ? fullTitle[0] : receivedTitle
        cell.configureCell(title: title, image: item.coverImage)
        
        return cell
    }
    
    func showDetails(origin: UIViewController, index: Int) {
        DetailsRouter.showDetails(from: origin, model: self.movieList[index])
    }
}
