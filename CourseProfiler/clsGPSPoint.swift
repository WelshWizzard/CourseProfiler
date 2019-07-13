//
//  clsGPSPoint.swift
//  CourseProfiler
//
//  Created by Shaw Goodwin on 13/07/2019.
//  Copyright © 2019 Shaw Goodwin. All rights reserved.
//
// Class to hold a coordinate
// 1.0 Initial implementation

import Foundation

class GPSPoint {
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    var elevation: Double = 0.0
    
    // Init for GPSPoint
    //init(longitude: Double, latitude: Double, elevation: Double) {
    //  self.longitude = longitude
    //self.latitude = latitude
    //self.elevation = elevation
    //}
    func setGPSPoint (longitude: Double, latitude: Double, elevation: Double){
        self.longitude = longitude
        self.latitude = latitude
        self.elevation = elevation
    }
    
    func setLongitude (longitude: Double){
        self.longitude = longitude
    }
    
    func getLongitude () -> Double {
        return self.longitude
    }
    
    func setLatitude (latitude: Double){
        self.latitude = latitude
    }
    
    func getLatitude () -> Double {
        return self.latitude
    }
    
    func setElevation (elevation: Double){
        self.elevation = elevation
    }
    
    func getElevation () -> Double {
        return self.elevation
    }
    
    func distancetoanotherpoint (to: GPSPoint) -> Double {
        // Checked outcome @ https://gps-coordinates.org/distance-between-coordinates.php
        let p180: Double = 0.017453292519943295
        let t = acos(cos(self.latitude * p180) * cos(to.latitude * p180) * cos((self.longitude * p180) - (to.longitude * p180)) + sin(self.latitude * p180) * sin(to.latitude * p180))
        
        return (6378206.4 * t)
    }
    
    func elevationtoanotherpoint (to: GPSPoint) -> Double {
        return (self.elevation - to.getElevation())
    }
}
