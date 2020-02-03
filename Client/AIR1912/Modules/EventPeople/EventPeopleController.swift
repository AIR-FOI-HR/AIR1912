//
//  EventPeopleController.swift
//  AIR1912
//
//  Created by Infinum on 03/02/2020.
//  Copyright © 2020 Infinum. All rights reserved.
//

import UIKit

class EventPeopleController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var selectedEvent: Event?
    var users: [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUsersOnEvent()
        
    }
    
    func getUsersOnEvent(){
        let provider = WebEventProvider()
        provider.getUsersOnEvent(for: self.selectedEvent!.id){ (result) in

            switch result{
            case .success(let users):
                self.presentAllUsersOnEvent(users: users)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func presentAllUsersOnEvent(users: [User]){
        self.users = users
        tableView.reloadData()
        print(users)
    }
    
    
    // table view delegate:
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard (self.users?.count) != nil else {
            return 0
        }
        
        return self.users!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath)
        let index = indexPath.row as Int
        
        cell.textLabel?.text = self.users![index].name
        
        return cell
    }


}
