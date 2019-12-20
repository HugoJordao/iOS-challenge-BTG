//
//  DetailViewModel.swift
//  HugoAJordaoProject
//
//  Created by Hugo Abolis Jordão on 13/12/19.
//  Copyright © 2019 Hugo Abolis Jordão. All rights reserved.
//

import Foundation
import UIKit

class DetailInteractor {
    let viewModel: MovieModel.ViewModel
    var worker: HomeWorker?
    
    init(viewModel: MovieModel.ViewModel, worker: HomeWorker? = HomeWorker()) {
        self.viewModel = viewModel
        self.worker = worker
    }
    
    
    func getViewData(completion: @escaping((_ images: [UIImage]) -> ())) -> MovieModel.ViewModel {
        var imageList: [UIImage] = []
        if viewModel.hasCover {
            imageList.append(viewModel.coverImage)
        }
        if let url = viewModel.movie?.backdrop_path {
            worker?.getImage(url: url, backupUrls: nil) { image, _ in
                imageList.append(image)
                completion(imageList)
            }
        }
        
        return viewModel
    }
}
