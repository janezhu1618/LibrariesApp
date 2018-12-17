//
//  BrooklynLibraryViewController.swift
//  NYCPublicLibraryApp
//
//  Created by Jane Zhu on 12/11/18.
//  Copyright © 2018 Jane Zhu. All() rights reserved.
//

import UIKit

class BrooklynLibraryViewController: UIViewController {
    
    @IBOutlet weak var brooklynLibraryTableView: UITableView!
    @IBOutlet weak var brooklynLibrarySearchBar: UISearchBar!
    
    private var refreshControl: UIRefreshControl!
    
    var brooklynLibraries = [BPLLocationsWrap]() {
        didSet {
            DispatchQueue.main.async {
                self.brooklynLibraryTableView.reloadData()
            }
        }
    }
    
    fileprivate func getAllBranches() {
        BrooklynLibraryAPI.getAllBranches { (brooklynLibraries, error) in
            if let error = error {
                print(error)
            }
            if let brooklynLibraries = brooklynLibraries {
                self.brooklynLibraries = brooklynLibraries
                self.brooklynLibraries = self.brooklynLibraries.sorted(by: {$0.data.title < $1.data.title})
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brooklynLibraryTableView.dataSource = self
        brooklynLibrarySearchBar.delegate = self
        getAllBranches()
        setupRefreshControl()
    }
    
    @objc private func fetchLibraries() {
        refreshControl.endRefreshing()
        getAllBranches()
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        brooklynLibraryTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(fetchLibraries), for: .valueChanged)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? BrooklynDetailViewController, let indexPath = brooklynLibraryTableView.indexPathForSelectedRow else { return }
        let library = brooklynLibraries[indexPath.row]
        destination.library = library
    }

}
extension BrooklynLibraryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brooklynLibraries.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = brooklynLibraryTableView.dequeueReusableCell(withIdentifier: "brooklynCell", for: indexPath)
        let library = brooklynLibraries[indexPath.row]
        cell.textLabel?.text = library.data.title
        return cell
    }
}

extension BrooklynLibraryViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else { return }
        brooklynLibraries = brooklynLibraries.filter{ $0.data.title.lowercased().components(separatedBy: " ").contains(searchText.lowercased()) || $0.data.address.lowercased().components(separatedBy: " ").contains(searchText.lowercased()) }
}
}
