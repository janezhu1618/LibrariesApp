//
//  ViewController.swift
//  NYCPublicLibraryApp
//
//  Created by Jane Zhu on 12/11/18.
//  Copyright © 2018 Jane Zhu. All rights reserved.
//

import UIKit

class QueensLibraryViewController: UIViewController {

    @IBOutlet weak var queensLibraryTableView: UITableView!
    @IBOutlet weak var queensLibrarySearchBar: UISearchBar!
    

    @IBOutlet var noResultsMessageView: UIView!
    
    private var refreshControl: UIRefreshControl!

    var queensLibraries = [QueensLibrary]() {
        didSet {
            DispatchQueue.main.async {
                self.queensLibraryTableView.reloadData()
            }
        }
    }
    
    fileprivate func getAllBranches() {
        QueensLibraryAPI.getAllBranches { (queensLibraries, error) in
            if let queensLibraries = queensLibraries {
                self.queensLibraries = queensLibraries
                self.queensLibraries = self.queensLibraries.sorted(by: {$0.name < $1.name})
            }
            if let error = error {
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queensLibraryTableView.backgroundView = noResultsMessageView
        queensLibraryTableView.dataSource = self
        queensLibrarySearchBar.delegate = self
        queensLibraryTableView.delegate = self
        getAllBranches()
        setupRefreshControl()
    }
    
    @objc private func fetchLibraries() {
        refreshControl.endRefreshing()
        getAllBranches()
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        queensLibraryTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(fetchLibraries), for: .valueChanged)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? QueensDetailViewController, let indexPath = queensLibraryTableView.indexPathForSelectedRow
            else { return }
        let library = queensLibraries[indexPath.row]
        destination.library = library
    }
}

extension QueensLibraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension QueensLibraryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return queensLibraries.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = queensLibraryTableView.dequeueReusableCell(withIdentifier: "queensCell", for: indexPath) as? QueensLibraryTableCell else { return UITableViewCell() }
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .lightGray
        } else {
            cell.backgroundColor = .white
        }
        let library = queensLibraries[indexPath.row]
        cell.label.text = library.name
        return cell
    }
}

extension QueensLibraryViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else { return }
        queensLibraries = queensLibraries.filter{ $0.name.lowercased().components(separatedBy: " ").contains(searchText.lowercased()) || $0.address.lowercased().components(separatedBy: " ").contains(searchText.lowercased()) }
    }
}

