//
//  Record.swift
//  SoundMap4
//
//  Created by Jared Williams on 9/13/17.
//  Copyright © 2017 Jared Williams. All rights reserved.
//

import Foundation


class DataRecord {
    var decibel: String!
    var location: String!
    var time: String!
    var lat: String!
    var long: String!
    var deviceType: String!
    
    
    init(decibel: String, lat: String, long: String, time: String, deviceType: String) {
        self.decibel = decibel
        self.lat = lat
        self.long = long
        self.time = time
        self.deviceType = deviceType
    }
}
