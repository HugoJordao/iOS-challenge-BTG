//
//  HomeViewController.swift
//  HugoAJordaoProject
//
//  Created by Hugo Abolis Jordão on 17/12/19.
//  Copyright © 2019 Hugo Abolis Jordão. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var homeButton: UITabBarItem!
    @IBOutlet weak var FavoritesButton: UITabBarItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tabBar: UITabBar!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let interactor = HomeInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "moviesCollectionView")
        setNeedsStatusBarAppearanceUpdate()
        view.isUserInteractionEnabled = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.isTranslucent = true
        tabBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tabBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        getMovies()
    }
    
    private func getMovies() {
        interactor.getMovies {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.view.isUserInteractionEnabled = true
                self.activityIndicator.stopAnimating()
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviesCollectionView", for: indexPath) as? MovieCollectionViewCell
        
        return interactor.getMovieCell(index: indexPath.row, cell: cell ?? MovieCollectionViewCell())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 34) / 2
        return CGSize(width: width , height: width * 1.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor.showDetails(origin: self, index: indexPath.row)
    }
    
}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
