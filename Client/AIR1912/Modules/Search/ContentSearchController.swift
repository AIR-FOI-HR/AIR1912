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

class ContentSearchController: UIViewController{
    
    // MARK: - Private outlets
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Private properties
    
    private var gamesDatasource = [Content]()
    private var movieDatasource = [Content]()
    var searchTitle = String()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        getLatestContent(for: .movie)
        
    }
    
}

extension ContentSearchController: UITableViewDelegate, UISearchBarDelegate {
    
    
    private func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        switch searchBar.selectedScopeButtonIndex {
        case 0:
            if searchText.isEmpty { return getLatestContent(for: .movie)}
            searchTitle = searchBar.text!
            return getSearchedContent(for: .movie)
        case 1:
            if searchText.isEmpty { return getLatestContent(for: .game)}
            searchTitle = searchBar.text!
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
        cell.configure(with: content)
        return cell
    }
}

