//
//  CoreDataManager.swift
//  SoundMap4
//
//  Created by Jared Williams on 9/17/17.
//  Copyright © 2017 Jared Williams. All rights reserved.
//

import Foundation
import CoreData
import UIKit



class CoreDataManager {
    
    static let sharedInstance = CoreDataManager()
    var objectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var settings: [Setting]!
    private var records: [Record]!
    
    
    func updateSettingData(databaseCode: String, deviceType:String) {
        
        if (settings!.count == 0) {
            
            print("Making...")
            let setting = Setting(context: objectContext)
            setting.databaseCode = databaseCode
            setting.deviceType = deviceType
        }
        
        else {
            
            let setting = settings![0]
            setting.databaseCode = databaseCode
            setting.deviceType = deviceType
        }
        
        
        
        
        do {
            try objectContext.save()
        }
        
        catch {
            print("Error saving data")
        }
    }
    
    func updatePoints() {
        
        if (settings.count == 0) {
            
            let setting = Setting(context: objectContext)
            setting.points = 1
        }
        
        else {
            let setting = settings[0]
            let previousPoints = setting.points
            setting.points = previousPoints + 1
        }
        
        do {
            try objectContext.save()
        }
        
        catch {
            print("Could not Update Points")
        }
        
    }
    
    func getData() {
        
        do {
            settings = try objectContext.fetch(Setting.fetchRequest())
        }
        
        catch {
            print("Error loading data")
        }
    }
    
    func retrieveSettingData() -> Setting {
        
        if settings.count > 0 {
            return settings[0]
        }
        
        else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            return Setting(context: context)
        }
        
    }
    
    func getDataCount() -> Int {
        return settings.count
    }
    
    func saveRecordData(decibel: String, lat: String, long: String, time: String) {
        let record = Record(context: objectContext)
        record.decibel = decibel
        record.lat = lat
        record.long = long
        record.time = time
        
        
        do {
            try objectContext.save()
        }
        
        catch {
            print("Could not save data locally")
        }
    }
    
    func getRecordData() {
        do {
            records = try objectContext.fetch(Record.fetchRequest())
        }
        
        catch {
            print("Could not load local data")
        }
    }
    
    func retrieveRecord(row: Int) -> Record {
        return records[row]
    }
    
    func getAllRecords() -> [Record] {
        return records
    }
    
    func getRecordCount() -> Int {
        return records.count
    }
    
    
        
    
    
}
