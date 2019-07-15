//
//  clsGPSPoint.swift
//  CourseProfiler
//
//  Created by Shaw Goodwin on 13/07/2019.
//  Copyright © 2019 Shaw Goodwin. All rights reserved.
//
// Class to hold a coordinate
// 1.0 Initial implementation
// 1.1 Moved calculation of differences func to Analysis Point

import Foundation

class GPSPoint {
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    var elevation: Double = 0.0
    
    func setGPSPoint (longitude: Double, latitude: Double, elevation: Double)
    {
        self.longitude = longitude
        self.latitude = latitude
        self.elevation = elevation
    }
    
    func setLongitude (longitude: Double)
    {
        self.longitude = longitude
    }
    
    func getLongitude () -> Double
    {
        return self.longitude
    }
    
    func setLatitude (latitude: Double)
    {
        self.latitude = latitude
    }
    
    func getLatitude () -> Double
    {
        return self.latitude
    }
    
    func setElevation (elevation: Double)
    {
        self.elevation = elevation
    }
    
    func getElevation () -> Double
    {
        return self.elevation
    }
}
