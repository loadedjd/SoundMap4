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
        return settings[0]
    }
    
    func getDataCount() -> Int {
        return settings.count
    }
        
    
    
}
