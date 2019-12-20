//
//  MovieModel.swift
//  HugoAJordaoProject
//
//  Created by Hugo Abolis Jordão on 12/12/19.
//  Copyright © 2019 Hugo Abolis Jordão. All rights reserved.
//

import Foundation
import UIKit

enum MovieModel
{
    struct Request
    {
        let idUser: String?
    }
    
//    typealias Response = [Movie]
    
    struct Response: Codable {
        let page: Int?
        let total_results: Int?
        let total_pages: Int?
        let results: [Movie]
    }
    
    struct ViewModel {
        var movie: Movie?
        var coverImage = UIImage()
        var hasCover = true
        var otherImages: [UIImage] = []

        init(movie: Movie) {
            self.movie = movie
        }
    }
    
    struct Movie: Codable {
        let popularity: Double?
        let vote_count: Int?
        let video: Bool?
        let adult: Bool?
        let original_language: String?
        let original_title: String?
        let genre_ids: [Int]?
        let vote_average: Double?
        let id: Int?
        let title: String?
        let overview: String?
        let release_date: String?
        let poster_path: String?
        let backdrop_path: String?
        
    }
}
