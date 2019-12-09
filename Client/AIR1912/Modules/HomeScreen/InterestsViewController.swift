//
//  InterestsViewController.swift
//  AIR1912
//
//  Created by Infinum on 01/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit
import Kingfisher

class InterestsViewController : UIViewController {
    
    // MARK: - Private outlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionView2: UICollectionView!
    
    // MARK: - Private properties
    
    private var gamesDatasource = [Content]()
    private var movieDatasource = [Content]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.dataSource = self
        collectionView2.dataSource = self
        
        getPopularContent(for: .game)
        getPopularContent(for: .movie)
    }
}

extension InterestsViewController {
    
    private func getPopularContent(for type: ContentType) {
        let provider: ContentProvider
        switch type {
        case .game:
            provider = GameProvider()
        case .movie:
            provider = MovieProvider()
        }
        
        provider.getPopularContent { (result) in
            switch result {
            case .success(let podaci):
                self.updateContent(for: type, result: podaci)
            case .failure(_):
                self.updateContent(for: type, result: [])
            }
        }
    }
    
    private func updateContent(for type: ContentType, result: [Content]) {
        switch type {
        case .game:
            gamesDatasource = result
            self.collectionView2.reloadData()
        case .movie:
            movieDatasource = result
            self.collectionView.reloadInputViews()
        }
    }
}

extension InterestsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === self.collectionView {
            return movieDatasource.count
        } else {
            return gamesDatasource.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCollectionViewCell", for: indexPath) as! InterestCollectionViewCell
        let content: Content
        if collectionView === self.collectionView{
            content = movieDatasource[indexPath.row]
        } else {
            content = gamesDatasource[indexPath.row]
        }
        cell.configure(with: content)
        return cell
    }
}
