//
//  ContentSearchController.swift
//  AIR1912
//
//  Created by Infinum on 13/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SkeletonView

class ContentSearchController: UIViewController{
    
    // MARK: - Private outlets
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    // MARK: - Private properties
    
    private var gamesDatasource = [Content]()
    private var movieDatasource = [Content]()
    private var searchTitle = String()
   
    // MARK: -Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.rowHeight = UITableView.automaticDimension
        setupSearchBar()
        table.showAnimatedSkeleton()
        getLatestContent(for: .movie)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getLatestContent(for: .movie)
        table.rowHeight = UITableView.automaticDimension
        setupSearchBar()
        self.tabBarController?.tabBar.tintColor = Theme.current.headingColor
        self.navigationController?.navigationBar.tintColor = Theme.current.headingColor
        let textAttributes = [NSAttributedString.Key.foregroundColor:Theme.current.headingColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    
    }
    
}

extension ContentSearchController: SkeletonTableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 5
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
       return "Cell"
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
    searchBar.setScopeBarButtonTitleTextAttributes([NSAttributedString.Key.foregroundColor : Theme.current.headingColor], for: .selected)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        switch searchBar.selectedScopeButtonIndex {
        case 0:
            if searchText.isEmpty { return getLatestContent(for: .movie)}
            searchTitle = GetTitle(initialString: searchBar.text!)
            return getSearchedContent(for: .movie)
        case 1:
            if searchText.isEmpty { return getLatestContent(for: .game)}
            searchTitle = GetTitle(initialString: searchBar.text!)
            return getSearchedContent(for: .game)
        default:
            return
        }

    }
    
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int){
        switch selectedScope {
        case 0:
            getLatestContent(for: .movie)
            searchBar.text = ""
        case 1:
            getLatestContent(for: .game)
            searchBar.text = ""
        default:
            break
        }
   
    }
    
    private func GetTitle(initialString: String) -> String {
        let components = initialString.components(separatedBy: .whitespaces)
        let completeTitle = components.joined(separator: "%20")
        return completeTitle
    }
   
    private func getSearchedContent(for type: ContentType) {
        
        let provider = ContentProviderFactory.contentProvider(forContentType: type)
        provider.getSearchedContent(title: searchTitle) { (result) in
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        self.table.hideSkeleton()
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
            self.table.reloadData()
        case .movie:
            movieDatasource = result
            self.table.reloadData()
        }
    }
    
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

}
    
    
extension ContentSearchController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.selectedScopeButtonIndex == 0 {
            return movieDatasource.count
        } else {
            return gamesDatasource.count
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableCell else {
            return UITableViewCell()
        }
        let content: Content
        if searchBar.selectedScopeButtonIndex == 0 {
            content = movieDatasource[indexPath.row]
        } else {
            content = gamesDatasource[indexPath.row]
        }
        cell.hideSkeleton()
        cell.configure(id: content.id, with: content)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "ContentDetails", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(identifier: "ContentDetails") as? ContentDetailsController else {
                return
            }
            let datasource: [Content]
            if searchBar.selectedScopeButtonIndex == 0 {
                datasource = movieDatasource
            } else if searchBar.selectedScopeButtonIndex == 1 {
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

