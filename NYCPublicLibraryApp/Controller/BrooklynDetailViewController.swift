//
//  BrooklynDetailViewController.swift
//  NYCPublicLibraryApp
//
//  Created by Jane Zhu on 12/14/18.
//  Copyright © 2018 Jane Zhu. All rights reserved.
//

import UIKit
import MapKit

class BrooklynDetailViewController: UIViewController {
    
    @IBOutlet weak var libraryName: UILabel!
    @IBOutlet weak var libraryInfo: UITextView!
    @IBOutlet weak var libraryMap: MKMapView!
    
    var library: BPLLocationsWrap!

    fileprivate func setUpMap(_ initialLocation: CLLocation) {
        centerMapOnLocation(location: initialLocation)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: BrooklynLibraryFormatter.formatCoordinates(getWhat: "latitude", coordinates: library.data.position), longitude: BrooklynLibraryFormatter.formatCoordinates(getWhat: "longitude", coordinates: library.data.position))
        annotation.title = library.data.title
        libraryMap.addAnnotation(annotation)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        libraryName.text = library.data.title
        libraryInfo.text =  "Address:\n" + library.data.address + "\n\nPhone Number: " + library.data.phone + "\n\nHours of Operation:\n" + BrooklynLibraryFormatter.formatHoursOfOperation(mon: library.data.Monday, tue: library.data.Tuesday, wed: library.data.Wednesday, thurs: library.data.Thursday, fri: library.data.Friday, sat: library.data.Saturday, sun: library.data.Sunday)
        let initialLocation = CLLocation(latitude: BrooklynLibraryFormatter.formatCoordinates(getWhat: "latitude", coordinates: library.data.position), longitude: BrooklynLibraryFormatter.formatCoordinates(getWhat: "longitude", coordinates: library.data.position))
        setUpMap(initialLocation)
       
    }
    let regionRadius: CLLocationDistance = 650
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        libraryMap.setRegion(coordinateRegion, animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func favoriteLibrary(_ sender: UIBarButtonItem) {
        let favorite = Favorite.init(name: nil, title: library.data.title, address: library.data.address, city: nil, postcode: nil, phone: library.data.phone, borough: "Brooklyn")
        
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
