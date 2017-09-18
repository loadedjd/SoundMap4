//
//  FirebaseManager.swift
//  SoundMap4
//
//  Created by Jared Williams on 9/13/17.
//  Copyright © 2017 Jared Williams. All rights reserved.
//

import Foundation
import Firebase

class FirebaseManager {
    static var sharedInstance = FirebaseManager()
    private var database = Database.database().reference().child("iOS")
    private var loadedData = [Dictionary<String, String>]()
    
    
    func loadDataFromDatabase() {
        database.observe(.value, with: { (snapshot: DataSnapshot) in
            
            if (snapshot.hasChildren()) {
                let temp = snapshot.value as! [String: Dictionary<String, String>]
                
                self.clearLoadedData()
                
                for dictionary in temp {
                    self.loadedData.append(dictionary.value)
                }
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadData"), object: nil)

            }
            
        })
    }
    
    func postDataToDatabase(recordData: DataRecord) {
        var dataDictionary = Dictionary<String, String>()
        
        dataDictionary["Decibels"] = recordData.decibel
        dataDictionary["time"] = recordData.time
        dataDictionary["Lat"] = recordData.lat
        dataDictionary["Long"] = recordData.long
        dataDictionary["Device"] = recordData.deviceType
        
        database.childByAutoId().setValue(dataDictionary)
    }
    
    func clearLoadedData() {
      loadedData.removeAll()
    }
    
    func retrieveDataRow(row: Int) -> Dictionary<String, String>{
        return loadedData[row]
    }
    
    func retrieveLoadedDataLength() -> Int{
        return loadedData.count
    }
    
    func retrieveAllData() -> [Dictionary<String, String>] {
        let data = self.loadedData
        return data
    }
}
