//
//  ViewController.swift
//  LaundryView
//
//  Created by Sam Singh on 8/12/18.
//  Copyright © 2018 Mango Hut. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tabView: UIView!
    
    let api = API()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    @IBAction func getData(_ sender: Any) {
        print("Getting laundry data...")
        api.getLaundryData()
        
    }
    
}

