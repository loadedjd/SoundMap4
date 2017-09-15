//
//  Location.swift
//  SoundMap3
//
//  Created by Jared Williams on 7/31/17.
//  Copyright © 2017 Jared Williams. All rights reserved.
//

import Foundation
import MapKit

class LocationManager: NSObject,CLLocationManagerDelegate {
    
    
    private var locationManager: CLLocationManager?
    var centerLocation: MKCoordinateRegion?
    private var authStatus: CLAuthorizationStatus?
    var currentLocation: CLLocation?
    static let sharedInstance = LocationManager()
    
    func setup() {
        
        
        self.locationManager = CLLocationManager()
        self.setupLocationManager()
        self.requestAuth()
        
        
    }
    
    func requestAuth()  {
        self.locationManager?.requestWhenInUseAuthorization()
        self.locationManager?.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authStatus = status
        
        if self.authStatus == CLAuthorizationStatus.authorizedWhenInUse {
            setupLocationManager()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.last!
    }
    
    func setupLocationManager() {
        
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager?.delegate = self
    }
    
  
    
    func getCenter() -> MKCoordinateRegion {
        return self.centerLocation!
    }
    
    
    
}
