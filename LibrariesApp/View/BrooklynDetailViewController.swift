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
        libraryPhoneNumber.text = "Phone: " + library.data.phone
        libraryHours.text = "Hours of Operation:" + library.data.Monday + library.data.Tuesday + library.data.Wednesday + library.data.Thursday + library.data.Friday + library.data.Saturday + library.data.Sunday
       
    }

}
