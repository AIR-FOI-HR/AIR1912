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
        
        getTrendingContent(for: .game)
        getTrendingContent(for: .movie)
    }
}

extension InterestsViewController {
    
    private func getTrendingContent(for type: ContentType) {
        let provider: ContentProvider
        switch type {
        case .game:
            provider = GameProvider()
        case .movie:
            provider = MovieProvider()
        }
        
        provider.getTrendingContent { (result) in
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
            self.collectionView.reloadData()
        }
    }
}

extension InterestsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieDatasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCollectionViewCell", for: indexPath) as! InterestCollectionViewCell
        let content = movieDatasource[indexPath.item]
        cell.configure(with: content)
        return cell
    }
}
