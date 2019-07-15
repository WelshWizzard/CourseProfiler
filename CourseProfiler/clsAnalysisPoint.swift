//
//  clsAnalysisPoint.swift
//  CourseProfiler
//
//  Created by Shaw Goodwin on 15/07/2019.
//  Copyright © 2019 Shaw Goodwin. All rights reserved.
//
//
// Class to hold a coordinate
// 1.0 Initial implementation

import Foundation
class AnalysisPoint: GPSPoint
{
    var distanceBetween: Double = 0.0
    var elevationDifference: Double = 0.0
    var slope : Double = 0.0
    
    func distancefromnanotherpoint (to: AnalysisPoint) -> Double
    {
        // Checked outcome @ https://gps-coordinates.org/distance-between-coordinates.php
        let p180: Double = 0.017453292519943295
        let t = acos(cos(self.latitude * p180) * cos(to.latitude * p180) * cos((self.longitude * p180) - (to.longitude * p180)) + sin(self.latitude * p180) * sin(to.latitude * p180))
        
        return (6378206.4 * t)
    }
    
    func elevationdifferencefromanotherpoint (to: AnalysisPoint) -> Double
    {
        return self.elevation - to.getElevation()
    }
    
    func slopefromanotherpoint (to: AnalysisPoint) -> Double
    {
        return (elevationdifferencefromanotherpoint(to: to) / distancefromnanotherpoint(to: to)) * 100
    }
    
    func calculateAnalysisFields (to: AnalysisPoint)
    {
        self.distanceBetween =  distancefromnanotherpoint(to: to)
        self.elevationDifference = elevationdifferencefromanotherpoint(to: to)
        self.slope = slopefromanotherpoint(to: to)
    }
    
    func setAnalysisPoint (longitude: Double, latitude: Double,  elevation: Double, distanceBetween: Double, elevationDifference: Double, slope: Double)
    {
        self.longitude = longitude
        self.latitude = latitude
        self.elevation = elevation
        self.distanceBetween = distanceBetween
        self.elevationDifference = elevationDifference
        self.slope = slope
    }
    
    func setElevationDifference (elevationDifference: Double)
    {
        self.elevationDifference = elevationDifference
    }
    
    func getEleveationDifference () -> Double
    {
        return self.elevationDifference
    }
    
    func setdistanceBetween (distanceBetween: Double)
    {
        self.distanceBetween = distanceBetween
    }
    
    func getdistanceBetween () -> Double
    {
        return self.distanceBetween
    }
    
    func setSlope (slope: Double)
    {
        self.slope = slope
    }
    
    func getslope () -> Double
    {
        return self.slope
    }
    
}
