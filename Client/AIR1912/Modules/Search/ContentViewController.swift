//
//  InterestsViewController.swift
//  AIR1912
//
//  Created by Infinum on 01/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit
import Kingfisher

class ContentViewController : UIViewController {
    
    // MARK: - Private outlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionView2: UICollectionView!
    
    @IBOutlet weak var segmentButton: UISegmentedControl!
    // MARK: - Private properties
    
    private var gamesDatasource = [Content]()
    private var movieDatasource = [Content]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLatestContent(for: .movie)
        getLatestContent(for: .game)
    }
    
    
    @IBAction func segmentClick(_ sender: Any) {
        switch segmentButton.selectedSegmentIndex {
        case 0:
            getLatestContent(for: .movie)
            getLatestContent(for: .game)
        case 1:
            getPopularContent(for: .movie)
            getPopularContent(for: .game)
        case 2:
            getTopRatedContent(for: .movie)
            getTopRatedContent(for: .game)
        default:
            break
        }
    }
    
}

extension ContentViewController {
    
    private func getPopularContent(for type: ContentType) {
        let provider = ContentProviderFactory.contentProvider(forContentType: type)
        provider.getPopularContent { (result) in
            switch result {
            case .success(let podaci):
                self.updateContent(for: type, result: podaci)
            case .failure(_):
                self.updateContent(for: type, result: [])
            }
        }
    }
    
    private func getLatestContent(for type: ContentType) {
        let provider = ContentProviderFactory.contentProvider(forContentType: type)
        provider.getLatestContent { (result) in
            switch result {
            case .success(let podaci):
                self.updateContent(for: type, result: podaci)
            case .failure(_):
                self.updateContent(for: type, result: [])
            }
        }
    }
    
    private func getTopRatedContent(for type: ContentType) {
        let provider = ContentProviderFactory.contentProvider(forContentType: type)
        provider.getTopRatedContent { (result) in
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

extension ContentViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === self.collectionView {
            return movieDatasource.count
        } else {
            return gamesDatasource.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as! ContentCollectionViewCell
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tap(_:)))
        cell.featuredImageView.addGestureRecognizer(tapGestureRecognizer)
        let content: Content
        if collectionView === self.collectionView{
            content = movieDatasource[indexPath.row]
        } else {
            content = gamesDatasource[indexPath.row]
        }
        cell.configure(with: content)
        return cell
    }
    
    @IBAction func tap(_ sender:ImageView){
        let ContentDetails:UIStoryboard = UIStoryboard(name: "ContentDetails", bundle: nil)
             let ContentDetailsController = ContentDetails.instantiateViewController(identifier: "ContentDetails") as! ContentDetailsController
        ContentDetailsController.id = 1
        ContentDetailsController.type = "game"
        ContentDetailsController.modalPresentationStyle = .popover
             self.present(ContentDetailsController, animated: true, completion: nil)
    }
}
