//
//  DetailViewViewController.swift
//  HugoAJordaoProject
//
//  Created by Hugo Abolis Jordão on 17/12/19.
//  Copyright © 2019 Hugo Abolis Jordão. All rights reserved.
//

import UIKit
import ImageSlideshow

class DetailViewController: UIViewController {
    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var popularity: UILabel!
    
    var interactor: DetailInteractor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        getViewData()
    }
    
    func getViewData() {
        let data = interactor?.getViewData(completion: { imageList in
            var input: [ImageSource] = []
            for image in imageList {
                input.append(ImageSource(image: image))
            }
            DispatchQueue.main.async {
                self.slideShow.setImageInputs(input)
            }
        })
        titleLabel.text = data?.movie?.title
        overviewLabel.text = data?.movie?.overview
        yearLabel.text = data?.movie?.release_date
        popularity.text = String(format: "%.2f", data?.movie?.popularity ?? 0.0)
    }

}
