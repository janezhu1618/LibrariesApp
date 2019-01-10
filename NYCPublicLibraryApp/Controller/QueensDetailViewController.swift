//
//  LibraryDetailViewController.swift
//  NYCPublicLibraryApp
//
//  Created by Jane Zhu on 12/13/18.
//  Copyright © 2018 Jane Zhu. All rights reserved.
//

import UIKit
import MapKit

class QueensDetailViewController: UIViewController {
    
    @IBOutlet weak var libraryName: UILabel!
    @IBOutlet weak var libraryInfo: UITextView!
    @IBOutlet weak var libraryMapView: MKMapView!
    
    var library: QueensLibrary!
    private var initialLocation: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
    
    fileprivate func setUpMap() {
        if let latitude = library.latitude, let longitude = library.longitude {
            if let safeLatitude = Double(latitude), let safeLongitude = Double(longitude) {
                initialLocation = CLLocation(latitude: safeLatitude, longitude: safeLongitude)
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: safeLatitude, longitude: safeLongitude)
                annotation.title = library.name
                libraryMapView.addAnnotation(annotation)
            }
        }
        centerMapOnLocation(location: initialLocation)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        libraryName.text = library.name
        libraryInfo.text = "Address:\n" + QueensLibraryFormatter.formatCompleteAddress(streetAddress: library.address, borough: "Queens", postcode: library.postcode) + "\n\nPhone Number: " + library.phone + "\n\nHours of Operation:\n" + QueensLibraryFormatter.formatHoursOfOperation(mon: library.mn, tue: library.tu
            , wed: library.we, thurs: library.th, fri: library.fr, sat: library.sa, sun: library.su)
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
        let favorite = Favorite.init(name: library.name, title: nil, address: library.address, city: library.city, postcode: library.postcode, phone: library.phone, borough: "Queens")
        
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
