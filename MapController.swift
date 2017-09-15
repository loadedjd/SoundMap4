//
//  MapController.swift
//  SoundMap4
//
//  Created by Jared Williams on 9/12/17.
//  Copyright © 2017 Jared Williams. All rights reserved.
//

import UIKit
import MapKit


class MapController: UIViewController {
    
    private var mapView: MKMapView!
    private var addButton: UIBarButtonItem!
    private var addedAnnotations: [MKPointAnnotation]!
    private var centerButton: UIBarButtonItem!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.addButton
        
        self.setupMapView()
        self.setupView()
        self.setupConstraints()
        self.addAnnotations()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.addAnnotations), name: NSNotification.Name(rawValue: "reloadData"), object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor.white
        self.addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.presentNewRecordController))
        self.addButton.tintColor = UIColor.white
        self.centerButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.centerButtonWasPushed))
        self.centerButton.tintColor = UIColor.white
        self.addedAnnotations = [MKPointAnnotation]()
        
        self.navigationItem.leftBarButtonItem = self.centerButton
        self.navigationItem.rightBarButtonItem = self.addButton
        
        self.view.addSubview(self.mapView)
    }
    
    func setupMapView() {
        self.mapView = MKMapView(frame: self.view.frame)
        self.setMapCenter(longitude: -82.9988889 , latitude: 39.9611111)
        self.mapView.showsUserLocation = true
    }
    
    func setupConstraints() {
        self.mapView?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.mapView?.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    func makeRegion(center: CLLocationCoordinate2D) -> MKCoordinateRegion{
        
        let region = MKCoordinateRegionMakeWithDistance(center, 30000, 30000)
        
        return region
    }
    
    func setMapCenter(longitude: Double, latitude: Double) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.mapView.setRegion(makeRegion(center: coordinate), animated: true)
        
    }
    
    @objc func centerButtonWasPushed() {
        self.setMapCenter(longitude: -82.9988889 , latitude: 39.9611111)
    }
    
    @objc func addAnnotations() {
        let entries = FirebaseManager.sharedInstance.retrieveAllData()
        
        if !(self.addedAnnotations.isEmpty) {
            self.addedAnnotations.removeAll()
        }
        
        for entry in entries {
            guard let decibels = entry["Decibels"] else {return }
            guard let lat = entry["Lat"] else {return }
            guard let long = entry["Long"] else {return}
            
            guard let latDegrees = CLLocationDegrees(lat) else {return }
            guard let longDegrees = CLLocationDegrees(long) else {return}
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(latDegrees, longDegrees)
            annotation.title = decibels
            
            
            self.addedAnnotations.append(annotation)
            self.mapView.addAnnotation(annotation)
           
        }
    }

    
    @objc func presentNewRecordController() {
        let nav = UINavigationController(rootViewController: NewRecordController())
        self.present(nav, animated: true, completion: nil)
    }

}
