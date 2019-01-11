//
//  BrooklynDetailViewController.swift
//  NYCPublicLibraryApp
//
//  Created by Jane Zhu on 12/14/18.
//  Copyright © 2018 Jane Zhu. All rights reserved.
//

import UIKit
import MapKit

class LibraryDetailViewController: UIViewController {
    
    @IBOutlet weak var libraryNameLabel: UILabel!
    @IBOutlet weak var libraryInfoTextView: UITextView!
    @IBOutlet weak var libraryMap: MKMapView!
    
    var brooklynLibrary: BPLLocationsWrap?
    var queensLibrary: QueensLibrary?
    var nyplLibrary: NYPL?
    private var libraryLongitude: Double = 0.0
    private var libraryLatitue: Double = 0.0
    private var libraryName = ""
    private var libraryAddress = ""
    private var libraryBorough = ""
    private var libraryPhone = ""
    private var libraryHoursOfOperation = ""
    
    fileprivate func setUpMap(_ initialLocation: CLLocation) {
        centerMapOnLocation(location: initialLocation)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: libraryLatitue, longitude: libraryLatitue)
        annotation.title = libraryName
        libraryMap.addAnnotation(annotation)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let brooklynLibrary = brooklynLibrary {
            self.brooklynLibrary = brooklynLibrary
            libraryLongitude = BrooklynLibraryFormatter.formatCoordinates(getWhat: "longitude", coordinates: brooklynLibrary.data.position)
            libraryLatitue = BrooklynLibraryFormatter.formatCoordinates(getWhat: "latitude", coordinates: brooklynLibrary.data.position)
            libraryName = brooklynLibrary.data.title
            libraryAddress = brooklynLibrary.data.address
            libraryPhone = brooklynLibrary.data.phone
            libraryBorough = "Brooklyn"
            libraryHoursOfOperation = BrooklynLibraryFormatter.formatHoursOfOperation(library: brooklynLibrary)
        } else if let queensLibrary = queensLibrary {
            self.queensLibrary = queensLibrary
            if let latitude = queensLibrary.latitude, let longitude = queensLibrary.longitude {
                if let safeLatitude = Double(latitude), let safeLongitude = Double(longitude) {
                        libraryLongitude = safeLatitude
                        libraryLatitue = safeLongitude
                }
            }
            libraryName = queensLibrary.name
            libraryAddress = QueensLibraryFormatter.formatCompleteAddress(library: queensLibrary)
            libraryPhone = queensLibrary.phone
            libraryBorough = "Queens"
            libraryHoursOfOperation = QueensLibraryFormatter.formatHoursOfOperation(library: queensLibrary)
        } else if let nyplLibrary = nyplLibrary {
            self.nyplLibrary = nyplLibrary
            libraryLongitude = nyplLibrary.the_geom.coordinates[0]
            libraryLatitue = nyplLibrary.the_geom.coordinates[1]
            libraryName = nyplLibrary.name
            libraryAddress = NYPLFormatter.formatCompleteAddress(library: nyplLibrary)
            libraryPhone = "n/a"
            libraryBorough = "NYPL"
            libraryHoursOfOperation = "Find info on:\n\(nyplLibrary.url)"
        }
        title = "\(libraryBorough) Library Detail"
        libraryNameLabel.text = libraryName
        libraryInfoTextView.text =  "Address:\n" + libraryAddress + "\n\nPhone Number: " + libraryPhone + "\n\nHours of Operation:\n" + libraryHoursOfOperation
        let initialLocation = CLLocation(latitude: libraryLatitue, longitude: libraryLongitude)
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
        let favorite = Favorite.init(name: libraryName, address: libraryAddress, city: nil, postcode: nil, phone: libraryPhone, borough: libraryBorough)
        
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
