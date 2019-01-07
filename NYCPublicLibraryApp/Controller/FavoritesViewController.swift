//
//  FavoritesViewController.swift
//  NYCPublicLibraryApp
//
//  Created by Jane Zhu on 1/7/19.
//  Copyright © 2019 Jane Zhu. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var favoritesTableView: UITableView!
    var favorites = [Favorite]() {
        didSet {
            DispatchQueue.main.async {
                self.favoritesTableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.dataSource = self
        LibraryAPIClient.getFavorites { (appError, favorites) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let favorites = favorites {
                self.favorites = favorites
            }
        }
    }


}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath)
        let library = favorites[indexPath.row]
        switch library.borough {
        case "Brooklyn":
            if let brooklynLibraryName = library.title {
                cell.textLabel?.text = "[Brooklyn] \(brooklynLibraryName)"
            }
            cell.detailTextLabel?.text = library.address
        case "Queens":
            if let queensLibraryName = library.name {
                cell.textLabel?.text = "[Queens] \(queensLibraryName)"
            }
            if let zipcode = library.postcode {
            cell.detailTextLabel?.text = "\(library.address), Queens, NY \(zipcode)"
            } else {
                cell.detailTextLabel?.text = "\(library.address), Queens, NY"
            }
        default:
            print("error")
        }
        return cell
    }
}
