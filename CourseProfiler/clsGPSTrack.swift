//
//  clsGPSTrack.swift
//  CourseProfiler
//
//  Created by Shaw Goodwin on 13/07/2019.
//  Copyright © 2019 Shaw Goodwin. All rights reserved.
//
//
// Class to hold a coordinate
// 1.0 Initial implementationimport Foundation

import Foundation

class GPSTrack{
    var trackName: String = ""
    var trackpoints: [GPSPoint] = []
    
    //init (trackName: String, trackpoints: [GPSPoint]) {
    //    self.trackName = trackName
    //    self.trackpoints = trackpoints
    //}
    
    func setTrackName (trackname: String) {
        self.trackName = trackname
    }
    
    func getTrackName () -> String {
        return self.trackName
    }
    
    func setTrackPoints (trackpoints: [GPSPoint]) {
        self.trackpoints = trackpoints
    }
    
    func getTrackPoints () -> [GPSPoint] {
        return self.trackpoints
    }
    
    func addTrackPoint (aTrackPoint: GPSPoint) {
        let tmpTrackPoint : GPSPoint = GPSPoint()
        
        tmpTrackPoint.setGPSPoint(longitude: aTrackPoint.getLongitude(), latitude: aTrackPoint.getLatitude(), elevation: aTrackPoint.getElevation())
        self.trackpoints.append(tmpTrackPoint)
    }
}
