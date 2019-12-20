//
//  HomeWorker.swift
//  HugoAJordaoProject
//
//  Created by Hugo Abolis Jordão on 12/12/19.
//  Copyright © 2019 Hugo Abolis Jordão. All rights reserved.
//

import Alamofire
import Foundation

class HomeWorker {
    var params = ["language": "pt-BR",
                  "page": "1"]
    let APIKey = "fdee34296b3a65e2f7d010105388a1c1"
    let imageBaseUrl = "https://image.tmdb.org/t/p/w300"
    enum urls: String {
        case mostPopular = "https://api.themoviedb.org/3/movie/popular"
        
    }
    
    func getMovieList(handler: @escaping( (_ response: MovieModel.Response?) -> ())) {
        var newParams = self.params
        newParams["api_key"] = APIKey
        
        Alamofire.request(urls.mostPopular.rawValue, parameters: newParams).responseJSON { response in
            self.checkResult(isSuccsess: response.result.isSuccess, data: response.data, handler: handler)
        }
    }
    
    func getImage(url: String, backupUrls: String?, hasCover: Bool = true, completion: @escaping((_ image: UIImage, _ hasCover: Bool) -> ()) ) {
        Alamofire.request(imageBaseUrl + url, parameters: ["api_key": APIKey]).responseData { data in
            print(data.request)
            print(data.debugDescription)
            if let imageData = data.data {
                if let image = UIImage(data: imageData) {
                    completion(image, hasCover)
                } else {
                    if let url = backupUrls {
                        self.getImage(url: url, backupUrls: nil, hasCover: false, completion: completion)
                    }
                }
            } else {
                
            }
        }
    }
    
    func checkResult(isSuccsess: Bool, data: Data?, handler: @escaping((_ response: MovieModel.Response?) -> ())) {
        if isSuccsess {
            if let responseData = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(MovieModel.Response.self, from: responseData)
                    handler(response)
                } catch {
                    print(error)
                    handler(nil)
                }
            } else {
                handler(nil)
            }
        } else {
            handler(nil)
        }
    }
}
