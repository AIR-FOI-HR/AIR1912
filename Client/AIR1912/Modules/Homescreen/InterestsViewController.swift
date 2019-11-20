//
//  InterestsViewController.swift
//  AIR1912
//
//  Created by Infinum on 20/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit

class InterestsViewController : UIViewController
{
    @IBOutlet weak var collectionView: UICollectionView!
    var interests = Interest.fetchInterests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        collectionView.dataSource = self
    }
}

// UICollectionViewDataSource

extension InterestsViewController:
    UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell =
        collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCollectionViewCell", for: indexPath) as! InterestCollectionViewCell
        let interest = interests[indexPath.item]
        
        cell.interest = interest
        
        return cell
    }
}
