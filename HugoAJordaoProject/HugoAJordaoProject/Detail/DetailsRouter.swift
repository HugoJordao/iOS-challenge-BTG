//
//  DetailsRouter.swift
//  HugoAJordaoProject
//
//  Created by Hugo Abolis Jordão on 13/12/19.
//  Copyright © 2019 Hugo Abolis Jordão. All rights reserved.
//

import Foundation
import UIKit

class DetailsRouter {
    static func showDetails(from: UIViewController, model: MovieModel.ViewModel) {
        let interactor = DetailInteractor(viewModel: model)
        let detailsVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        detailsVC.interactor = interactor
        from.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
