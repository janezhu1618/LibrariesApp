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

}
