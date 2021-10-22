//
//  ContactListViewController.swift
//  RandomContacts
//
//  Created by Ярослав Бойко on 21.10.2021.
//

import UIKit
import Alamofire

class ContactListViewController: UITableViewController {
    
    private let url = "https://randomuser.me/api/"
    private var contacts: [Contact] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
        doNetworking()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contact", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
        content.imageProperties.cornerRadius = 50
        
        let contact = contacts[indexPath.row]
        content.text = contact.name?.first
        content.secondaryText = contact.name?.last
        
        if let imageURL = contact.picture?.thumbnail {
            NetworkManager.shared.fetchData(from: imageURL) { imageData in
                content.image = UIImage(data: imageData)
                cell.contentConfiguration = content
            }
        }
        
        cell.contentConfiguration = content
        return cell
    }
    
    private func doNetworking() {
        NetworkManager.shared.fetchContacts(url: url) { contacts in
            self.contacts = contacts
            self.tableView.reloadData()
        }
    }

}
