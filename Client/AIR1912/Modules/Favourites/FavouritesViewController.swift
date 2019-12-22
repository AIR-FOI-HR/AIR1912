//
//  FavouritesVC.swift
//  AIR1912
//
//  Created by Leo Leljak on 27/11/2019.
//  Copyright © 2019 Infinum. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController {

    // MARK: - Private outlets
    
    @IBOutlet weak var favouriteMoviesCollectionView: UICollectionView!
    
    @IBOutlet weak var favouriteGamesCollectionView: UICollectionView!
    
    // MARK: - Private properties
    
    private var gamesDataSource = [DBContent]()
    private var moviesDataSource = [DBContent]()
    let keychain:UserKeychain = UserKeychain()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userId:Int = keychain.getID()!
        
        getFavouriteContent(for: .movie, userId: userId)
        getFavouriteContent(for: .game, userId: userId)
        
    }

}

extension FavouritesViewController {
    
    private func getFavouriteContent(for type: ContentType, userId: Int){
        _ = getFavouritesByUserId(with: userId, contentType: type.rawValue) { (result) in
            switch result {
            case .success(let podaci):
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
