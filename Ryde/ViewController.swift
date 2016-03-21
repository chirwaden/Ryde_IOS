//
//  ViewController.swift
//  Ryde
//
//  Created by Dennis Chirwa on 20/03/2016.
//  Copyright © 2016 Clavel Incorporated Limited. All rights reserved.
//

import UIKit
import CoreLocation
import AddressBookUI



class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locMgr = CLLocationManager()
    
    @IBOutlet weak var myLat: UILabel!
    @IBOutlet weak var myLong: UILabel!
    @IBOutlet weak var myCourse: UILabel!
    @IBOutlet weak var mySpeed: UILabel!
    @IBOutlet weak var myAddress: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locMgr.desiredAccuracy = kCLLocationAccuracyBest
        locMgr.requestWhenInUseAuthorization()
        locMgr.startUpdatingLocation()
        locMgr.delegate = self //important

    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let myCurrentLoc = locations[locations.count - 1]
        
        myLat.text = "\(myCurrentLoc.coordinate.latitude)"
        myLong.text = "\(myCurrentLoc.coordinate.longitude)"
        myCourse.text = "\(myCurrentLoc.course)"
        mySpeed.text = "\(myCurrentLoc.speed)"
        
        
        
        // Geo Coder - for rever
        
        CLGeocoder().reverseGeocodeLocation(myCurrentLoc) { (myPlacements, myError) -> Void in
            
            if myError != nil
            {
                // error handler
            }
            
            if let myPlacement = myPlacements?.first
            {
                let myAddress = " \(myPlacement.name!)\n" + "\(myPlacement.locality!)\n" + "\(myPlacement.subAdministrativeArea!)\n" + "\(myPlacement.postalCode!)\n"
                
                self.myAddress.text = "\(myAddress)"
            }
        }
        
    }

}

