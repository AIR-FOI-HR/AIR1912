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
    private let decoder = JSONDecoder()
    private let headers = [
        "x-rapidapi-host": "rawg-video-games-database.p.rapidapi.com",
        "x-rapidapi-key": "8e24dd9e5dmshb82b8dcc0df400ep1f2bc1jsn0e0a57afa70e"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        getLatestContent(for: .movie)
        getLatestContent(for: .game)
    }
    
}

extension ContentSearchController: UITableViewDelegate, UISearchBarDelegate {
    
    
    private func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String, for type: ContentType, completion: @escaping (Result<[Content]>) -> Void){
        
        
        
        let asdtitle = searchBar.text!
    
        let API_KEY = "e965f161f0ec9f1c3931495b713226e0"
        let movieTitle = asdtitle
        Alamofire
            .request("https://api.themoviedb.org/3/search/movie?api_key=\(API_KEY)&query=\(movieTitle)")
        .responseDecodableObject(decoder: decoder) { (response: DataResponse<MovieResponse>) in
            switch response.result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int){
   
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
        if tableView === self.table {
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
        if tableView === self.table{
            content = movieDatasource[indexPath.row]
        } else {
            content = gamesDatasource[indexPath.row]
        }
        cell.configure(with: content)
        return cell
    }
}

