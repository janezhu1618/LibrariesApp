//
//  LibraryDetailViewController.swift
//  NYCPublicLibraryApp
//
//  Created by Jane Zhu on 12/13/18.
//  Copyright © 2018 Jane Zhu. All rights reserved.
//

import UIKit

class QueensDetailViewController: UIViewController {
    
    @IBOutlet weak var libraryName: UILabel!
    @IBOutlet weak var libraryAddress: UILabel!
    @IBOutlet weak var libraryPhoneNumber: UILabel!
    @IBOutlet weak var libraryHours: UILabel!
    
    var library: QueensLibrary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        libraryName.text = library.name
        libraryAddress.text = DataSupport.formatCompleteAddress(streetAddress: library.address, borough: "Queens", postcode: library.postcode)
        libraryPhoneNumber.text = "Phone: " + library.phone
        libraryHours.text = DataSupport.formatHoursOfOperation(mon: library.mn, tue: library.tu
            , wed: library.we, thurs: library.th, fri: library.fr, sat: library.sa, sun: library.su)
    }
    

}
