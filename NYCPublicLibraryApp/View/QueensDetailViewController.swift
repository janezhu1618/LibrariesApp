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
    @IBOutlet weak var libraryInfo: UITextView!
    
    var library: QueensLibrary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        libraryName.text = library.name
        libraryInfo.text = "Address:\n" + QueensLibraryFormatter.formatCompleteAddress(streetAddress: library.address, borough: "Queens", postcode: library.postcode) + "\n\nPhone Number:\n" + library.phone + "\n\nHours of Operation:\n" + QueensLibraryFormatter.formatHoursOfOperation(mon: library.mn, tue: library.tu
            , wed: library.we, thurs: library.th, fri: library.fr, sat: library.sa, sun: library.su)
    }
    

}
