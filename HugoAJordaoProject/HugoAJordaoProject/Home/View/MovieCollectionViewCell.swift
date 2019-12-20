//
//  MovieCollectionViewCell.swift
//  HugoAJordaoProject
//
//  Created by Hugo Abolis Jordão on 12/12/19.
//  Copyright © 2019 Hugo Abolis Jordão. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(title: String, image: UIImage) {
        movieImage.clipsToBounds = true
        movieImage.layer.cornerRadius = 5.0
        titleLabel.text = title
        movieImage.image = image
    }
}
