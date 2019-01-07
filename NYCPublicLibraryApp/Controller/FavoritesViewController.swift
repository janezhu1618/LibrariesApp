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
    private var refreshControl: UIRefreshControl!
    
    var favorites = [Favorite]() {
        didSet {
            DispatchQueue.main.async {
                self.favoritesTableView.reloadData()
            }
        }
    }
    
    @objc private func fetchFavorites() {
        refreshControl.endRefreshing()
        getFavorites()
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        favoritesTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(fetchFavorites), for: .valueChanged)
    }

    fileprivate func getFavorites() {
        LibraryAPIClient.getFavorites { (appError, favorites) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let favorites = favorites {
                self.favorites = favorites
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.dataSource = self
        getFavorites()
        setupRefreshControl()
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
