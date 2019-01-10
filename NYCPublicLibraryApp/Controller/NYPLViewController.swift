//
//  NYPLViewController.swift
//  NYCPublicLibraryApp
//
//  Created by Jane Zhu on 1/9/19.
//  Copyright © 2019 Jane Zhu. All rights reserved.
//

import UIKit

class NYPLViewController: UIViewController {

    @IBOutlet weak var nyplTableView: UITableView!
    
    @IBOutlet var noItemMessageView: UIView!
     private var refreshControl: UIRefreshControl!
    
    private var nypl = [[NYPL]]() {
        didSet {
            DispatchQueue.main.async {
                self.nyplTableView.reloadData()
            }
        }
    }
    fileprivate func getAllBranches() {
        NyplAPI.getAllBranches { (nypl, appError) in
            if let appError = appError {
                print(appError)
            } else if let nypl = nypl {
                self.nypl = [nypl.filter{ $0.city == "New York" }, nypl.filter{ $0.city == "Bronx"}, nypl.filter{ $0.city == "Staten Island" }]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nyplTableView.backgroundView = noItemMessageView
        nyplTableView.dataSource = self
        nyplTableView.delegate = self
        getAllBranches()
    }
    
    @objc private func fetchLibraries() {
        refreshControl.endRefreshing()
        getAllBranches()
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        nyplTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(fetchLibraries), for: .valueChanged)
    }
    
}

extension NYPLViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Manhattan"
        case 1:
            return "Bronx"
        case 2:
            return "Staten Island"
        default:
            return "error"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nypl.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = nyplTableView.dequeueReusableCell(withIdentifier: "nyplCell", for: indexPath) as? NYPLCell else { return UITableViewCell() }
        let library = nypl[indexPath.section][indexPath.row]
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .lightGray
        } else {
            cell.backgroundColor = .white
        }
        cell.label.text = library.name
        return cell
    }
}

extension NYPLViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return nypl.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
