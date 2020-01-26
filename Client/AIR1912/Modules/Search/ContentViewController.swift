//
//  InterestsViewController.swift
//  AIR1912
//
//  Created by Infinum on 01/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit
import Kingfisher
import SkeletonView

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
        
        self.view.isSkeletonable = false
        getLatestContent(for: .movie)
        getLatestContent(for: .game)
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(true)
        
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
        self.collectionView.showAnimatedGradientSkeleton()
        self.collectionView2.showAnimatedGradientSkeleton()
        let provider = ContentProviderFactory.contentProvider(forContentType: type)
        provider.getPopularContent { (result) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {  self.collectionView.hideSkeleton()
                self.collectionView2.hideSkeleton()
            }
            switch result {
            case .success(let podaci):
                self.updateContent(for: type, result: podaci)
            case .failure(_):
                self.updateContent(for: type, result: [])
            }
        }
    }
    
    private func getLatestContent(for type: ContentType) {
        self.collectionView.showAnimatedGradientSkeleton()
        self.collectionView2.showAnimatedGradientSkeleton()
        let provider = ContentProviderFactory.contentProvider(forContentType: type)
        provider.getLatestContent { (result) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {  self.collectionView.hideSkeleton()
                self.collectionView2.hideSkeleton()
            }
            switch result {
            case .success(let podaci):
                self.updateContent(for: type, result: podaci)
            case .failure(_):
                self.updateContent(for: type, result: [])
            }
        }
    }
    
    private func getTopRatedContent(for type: ContentType) {
        self.collectionView.showAnimatedGradientSkeleton()
        self.collectionView2.showAnimatedGradientSkeleton()
        let provider = ContentProviderFactory.contentProvider(forContentType: type)
        provider.getTopRatedContent { (result) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {  self.collectionView.hideSkeleton()
                self.collectionView2.hideSkeleton()
            }
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

extension ContentViewController: SkeletonCollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "ContentCollectionViewCell"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === self.collectionView {
            return movieDatasource.count
        } else {
            return gamesDatasource.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as! ContentCollectionViewCell
        let content: Content
        if collectionView === self.collectionView{
            content = movieDatasource[indexPath.row]
        } else {
            content = gamesDatasource[indexPath.row]
        }
        cell.configure(with: content)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ContentDetails", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "ContentDetails") as? ContentDetailsController else {
            return
        }
        let datasource: [Content]
        if collectionView === self.collectionView {
            datasource = movieDatasource
        } else if collectionView == self.collectionView2 {
            datasource = gamesDatasource
        } else {
            return
        }
        let item = datasource[indexPath.row]
        viewController.id = item.id
        viewController.type = item.type
        viewController.modalPresentationStyle = .popover
        self.present(viewController, animated: true, completion: nil)
    }
}
