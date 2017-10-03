//
//  FirebaseManager.swift
//  SoundMap4
//
//  Created by Jared Williams on 9/13/17.
//  Copyright © 2017 Jared Williams. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class FirebaseManager {
    static var sharedInstance = FirebaseManager()
    private var database = Database.database().reference().child("iOS")
    var loadedData: [String: Dictionary<String, String>]?
    
    
    
    
    func getData(path: String, completion: (()-> ())?) {
        var dictionary: [String: Dictionary<String, String>] = [:]
        
        self.database.observe(.value) { (snapshot: DataSnapshot) in
            dictionary = snapshot.value as! [String: Dictionary<String, String>]
            self.loadedData = dictionary
            completion?()
        }
        
        
      
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
    
    func returnLoadedData() -> [DataRecord] {
        var returnData:[DataRecord]  = []
       
        
       
            
        
            
            for data in self.loadedData! {
                let record = DataRecord()
                guard let decibel = data.value["Decibels"]  else {return [DataRecord()]}
                guard let lat = data.value["Lat"]  else {return [DataRecord()]}
                guard let long = data.value["Long"]  else {return [DataRecord()]}
                guard let time = data.value["time"]  else {return [DataRecord()]}
                guard let device = data.value["Device"]  else {return [DataRecord()]}
                
                
                
                record.decibel = decibel
                record.lat = lat
                record.long = long
                record.time = time
                record.deviceType = device
                
                
                
                returnData.append(record)
        }
        
        return returnData
    }
}
