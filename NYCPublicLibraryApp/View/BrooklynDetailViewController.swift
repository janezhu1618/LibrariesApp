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
    @IBOutlet weak var libraryInfo: UITextView!
    
    var library: BPLLocationsWrap!

    override func viewDidLoad() {
        super.viewDidLoad()
        libraryName.text = library.data.title
        libraryInfo.text =  "Address:\n" + library.data.address + "\n\nPhone Number:\n" + library.data.phone + "\n\nHours of Operation:\n" + BrooklynLibraryFormatter.formatHoursOfOperation(mon: library.data.Monday, tue: library.data.Tuesday, wed: library.data.Wednesday, thurs: library.data.Thursday, fri: library.data.Friday, sat: library.data.Saturday, sun: library.data.Sunday)
       
    }

}
