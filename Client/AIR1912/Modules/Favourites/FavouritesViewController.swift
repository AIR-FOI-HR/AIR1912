//
//  FavouritesVC.swift
//  AIR1912
//
//  Created by Leo Leljak on 27/11/2019.
//  Copyright © 2019 Infinum. All rights reserved.
//

import UIKit
import SkeletonView

class FavouritesViewController: UIViewController {

    // MARK: - Private outlets
    
    @IBOutlet weak var favouriteMoviesCollectionView: UICollectionView!
    
    @IBOutlet weak var favouriteGamesCollectionView: UICollectionView!
    
    @IBOutlet weak var favouriteLabel: UILabel!
    @IBOutlet weak var favourite2Label: UILabel!
    // MARK: - Private properties
    
    private var gamesDataSource = [DBContent]()
    private var moviesDataSource = [DBContent]()
    let keychain:UserKeychain = UserKeychain()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userId:Int = keychain.getID()!
        self.getFavouriteContent(for: .movie, userId: userId)
        self.getFavouriteContent(for: .game, userId: userId)
        
        favouriteLabel.textColor = Theme.current.headingColor
        favourite2Label.textColor = Theme.current.headingColor
        self.tabBarController?.tabBar.tintColor = Theme.current.headingColor
        self.navigationController?.navigationBar.tintColor = Theme.current.headingColor
        let textAttributes = [NSAttributedString.Key.foregroundColor:Theme.current.headingColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func getFavouriteContent(for type: ContentType, userId: Int){
        self.favouriteMoviesCollectionView.showAnimatedGradientSkeleton()
        self.favouriteGamesCollectionView.showAnimatedGradientSkeleton()
        let provider = WebContentProvider()
        _ = provider.getFavouritesByUserId(with: userId, contentType: type) { (result) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {  self.favouriteMoviesCollectionView.hideSkeleton()
                self.favouriteGamesCollectionView.hideSkeleton()
            }
            switch result {
            case .success(let podaci):
                print(podaci)
                self.updateContent(for: type, result: podaci)
            case .failure(_):
                self.updateContent(for: type, result: [])
            }
        }
    }

    
    private func updateContent(for type: ContentType, result: [DBContent]) {
        switch type {
        case .game:
            gamesDataSource = result
            self.favouriteGamesCollectionView.reloadData()
        case .movie:
            moviesDataSource = result
            self.favouriteMoviesCollectionView.reloadData()
        }
    }

}

extension FavouritesViewController: SkeletonCollectionViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "FavouritesCollectionViewCell"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === self.favouriteMoviesCollectionView {
                   return moviesDataSource.count
               } else {
                   return gamesDataSource.count
               }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouritesCollectionViewCell", for: indexPath) as! FavouritesCollectionViewCell
        let content: DBContent
        if collectionView === self.favouriteMoviesCollectionView{
            content = moviesDataSource[indexPath.row]
            cell.configure(with: content)
        } else {
            content = gamesDataSource[indexPath.row]
            cell.configure(with: content)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let storyboard = UIStoryboard(name: "ContentDetails", bundle: nil)
           guard let viewController = storyboard.instantiateViewController(identifier: "ContentDetails") as? ContentDetailsController else {
               return
           }
           let datasource: [DBContent]
        if collectionView === self.favouriteMoviesCollectionView {
            datasource = moviesDataSource
        } else if collectionView == self.favouriteGamesCollectionView {
            datasource = gamesDataSource
           } else {
               return
           }
           let item = datasource[indexPath.row]
           viewController.id = item.sourceEntityId
           viewController.type = ContentType(rawValue: item.type!)!
           viewController.modalPresentationStyle = .popover
           self.present(viewController, animated: true, completion: nil)
       }
    
    

}
