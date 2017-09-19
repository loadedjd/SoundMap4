//
//  RecordController.swift
//  SoundMap4
//
//  Created by Jared Williams on 9/12/17.
//  Copyright © 2017 Jared Williams. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class RecordController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var addButton: UIBarButtonItem!


    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        self.collectionView!.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData), name: NSNotification.Name(rawValue: "reloadData"), object: nil)
    
    }
    
    func setupView() {
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.alwaysBounceVertical = true
        self.addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.presentNewRecordController))
        self.addButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = self.addButton
    }
    
    @objc func reloadData() {
        self.collectionView?.reloadData()
    }
    
    @objc func presentNewRecordController() {
        let nav = UINavigationController(rootViewController: NewRecordController())
        self.present(nav, animated: true, completion: nil)
    }

    
    func setupCell(decibelString: String, locationString: String, timeString: String, indexpPath: IndexPath) -> FeedCell {
        let cell = collectionView?.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexpPath) as! FeedCell
        cell.setDecibel(text: decibelString)
        cell.setTimeLabel(text: timeString)
        cell.setLocationLabel(text: locationString)
        
        if (Double(decibelString)! < 60.0) {
            cell.setColorView(color: UIColor.green)
        }
        
        if (Double(decibelString)! >= 60 && Double(decibelString)! < 80) {
            cell.setColorView(color: UIColor.yellow)
        }
        
        else {
            cell.setColorView(color: UIColor.red)
        }
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if CoreDataManager.sharedInstance.retrieveSettingData().databaseCode == "BUCKS" {
            return FirebaseManager.sharedInstance.retrieveLoadedDataLength()
        }
        
        else {
            return CoreDataManager.sharedInstance.getRecordCount()
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell: UICollectionViewCell!
        
        if let databaseCode = CoreDataManager.sharedInstance.retrieveSettingData().databaseCode {
            if (databaseCode == "BUCKS") {
                
                let entry = FirebaseManager.sharedInstance.retrieveDataRow(row: indexPath.row)
                guard let decibel = entry["Decibels"] else {return setupCell(decibelString: "", locationString: "", timeString: "", indexpPath: indexPath)}
                guard let time = entry["time"] else {return setupCell(decibelString: "", locationString: "", timeString: "", indexpPath: indexPath)}
                guard let lat = entry["Lat"]?.truncate(length: 6) else {return setupCell(decibelString: "", locationString: "", timeString: "", indexpPath: indexPath)}
                guard let long = entry["Long"]?.truncate(length: 6) else {return setupCell(decibelString: "", locationString: "", timeString: "", indexpPath: indexPath)}
                
                let location = "\(lat) N \(long) W"
                cell = setupCell(decibelString: decibel, locationString: location, timeString: time, indexpPath: indexPath)
            }
            
            
            else {
                let entry = CoreDataManager.sharedInstance.retrieveRecord(row: indexPath.row)
                guard let decibel = entry.decibel else {return setupCell(decibelString: "", locationString: "", timeString: "", indexpPath: indexPath)}
                guard let time = entry.time else {return setupCell(decibelString: "", locationString: "", timeString: "", indexpPath: indexPath)}
                guard let lat = entry.lat?.truncate(length: 6) else {return setupCell(decibelString: "", locationString: "", timeString: "", indexpPath: indexPath)}
                guard let long = entry.long?.truncate(length: 6) else {return setupCell(decibelString: "", locationString: "", timeString: "", indexpPath: indexPath)}
                
                let location = "\(lat) N \(long) W"
                cell = setupCell(decibelString: decibel, locationString: location, timeString: time, indexpPath: indexPath)
                
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 100)
    }

}
