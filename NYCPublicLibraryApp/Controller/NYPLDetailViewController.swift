//
//  NYPLDetailViewController.swift
//  NYCPublicLibraryApp
//
//  Created by Jane Zhu on 1/9/19.
//  Copyright © 2019 Jane Zhu. All rights reserved.
//

import UIKit
import MapKit

class NYPLDetailViewController: UIViewController {

    @IBOutlet weak var libraryName: UILabel!
    @IBOutlet weak var libraryInfo: UITextView!
    @IBOutlet weak var libraryMapView: MKMapView!
    
    var library: NYPL!
    private var initialLocation: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
    
    fileprivate func setUpMap() {
                initialLocation = CLLocation(latitude: library.the_geom.coordinates[1], longitude: library.the_geom.coordinates[0])
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: library.the_geom.coordinates[1], longitude: library.the_geom.coordinates[0])
                annotation.title = library.name
                libraryMapView.addAnnotation(annotation)
        centerMapOnLocation(location: initialLocation)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        libraryName.text = library.name
        libraryInfo.text = "Address:\n" 
        setUpMap()
    }
    
    let regionRadius: CLLocationDistance = 650
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        libraryMapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func favoriteLibrary(_ sender: UIBarButtonItem) {
        var address = library.housenum ?? ""
        address += " "
        address += library.streetname
        let favorite = Favorite.init(name: library.name, address: address, city: library.city, postcode: library.zip, phone: nil, borough: library.city)
        
        do {
            let data = try JSONEncoder().encode(favorite)
            LibraryAPIClient.favoritesLibrary(data: data) { (appError, success) in
                if let appError = appError {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error Message", message: appError.errorMessage())
                    }
                } else if success {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Successfully favorited library", message: "")
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Library was not favorited", message: "")
                    }
                }
            }
        } catch {
            print("encoding error: \(error)")
        }
    }
    
}
