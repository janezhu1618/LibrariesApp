//
//  BrooklynDetailViewController.swift
//  NYCPublicLibraryApp
//
//  Created by Jane Zhu on 12/14/18.
//  Copyright © 2018 Jane Zhu. All rights reserved.
//

import UIKit

class BrooklynDetailViewController: UIViewController {
    
    @IBOutlet weak var libraryName: UILabel!
    @IBOutlet weak var libraryAddress: UILabel!
    @IBOutlet weak var libraryPhoneNumber: UILabel!
    @IBOutlet weak var libraryHours: UILabel!
    
    var library: BPLLocationsWrap!

    override func viewDidLoad() {
        super.viewDidLoad()
        libraryName.text = library.data.title
        libraryAddress.text = "Address: \n" + library.data.address
        libraryPhoneNumber.text = BrooklynLibraryFormatter.formatPhoneNumber(phone: library.data.phone)
        libraryHours.text = BrooklynLibraryFormatter.formatHoursOfOperation(mon: library.data.Monday, tue: library.data.Tuesday, wed: library.data.Wednesday, thurs: library.data.Thursday, fri: library.data.Friday, sat: library.data.Saturday, sun: library.data.Sunday)
       
    }

}
