//
//  clsAnalysisTrack.swift
//  CourseProfiler
//
//  Created by Shaw Goodwin on 15/07/2019.
//  Copyright © 2019 Shaw Goodwin. All rights reserved.
//
// Class to hold a coordinate
// 1.0 Initial implementationimport Foundation

import Foundation

class AnalysisTrack
{
    var analysisTrackName: String = ""
    var analysisMaxElevation: Double = 0.0
    var analysisMinElevation: Double = 0.0
    var analysisTrackDistance: Double = 0.0
    var analysisMaxSlope: Double = 0.0
    var analysisMinSlope: Double = 0.0
    var analysisTrackPoints: [AnalysisPoint] = []
    
    func setAnalysisTrackName (trackname: String)
    {
        self.analysisTrackName = trackname
    }
    
    func getAnalysisTrackName () -> String
    {
        return self.analysisTrackName
    }
    
    func updateAnalysisSummaries (aAnalysisTrackPoint: AnalysisPoint)
    {
        //Update Distance
        analysisTrackDistance += aAnalysisTrackPoint.distanceBetween
        if aAnalysisTrackPoint.elevation > self.analysisMaxElevation
        {
            self.analysisMaxElevation = aAnalysisTrackPoint.elevation
        }
      
        if aAnalysisTrackPoint.elevation < self.analysisMinElevation
        {
            self.analysisMinElevation = aAnalysisTrackPoint.elevation
        }
        if aAnalysisTrackPoint.slope > self.analysisMaxSlope
        {
            self.analysisMaxSlope = aAnalysisTrackPoint.slope
        }
        
        if aAnalysisTrackPoint.slope < self.analysisMinSlope
        {
            self.analysisMinSlope = aAnalysisTrackPoint.slope
        }
        
    }
    
    func analyseGPXTrack(aGPXFile: GPXFile)
    {
        self.analysisTrackName = aGPXFile.GPXTrack.getTrackName()
        for i in 0..<aGPXFile.GPXTrack.trackpoints.count-1
        {
            self.addAnalysisTrackPoint(aAnalysisTrackPoint: aGPXFile.GPXTrack.trackpoints[i])
        }
    }
    
    func addAnalysisTrackPoint (aAnalysisTrackPoint: GPSPoint)
    {
        let tmpAnalysisTrackPoint : AnalysisPoint = AnalysisPoint()
        
        tmpAnalysisTrackPoint.setGPSPoint(longitude: aAnalysisTrackPoint.getLongitude(), latitude: aAnalysisTrackPoint.getLatitude(), elevation: aAnalysisTrackPoint.getElevation())
        if self.analysisTrackPoints.count > 0
        {
            // If it is not the first then calculate
            tmpAnalysisTrackPoint.calculateAnalysisFields(to: self.analysisTrackPoints[self.analysisTrackPoints.count - 1])
            updateAnalysisSummaries(aAnalysisTrackPoint: tmpAnalysisTrackPoint)
        }
        else
        {
            self.analysisMaxElevation = aAnalysisTrackPoint.getElevation()
            self.analysisMinElevation = aAnalysisTrackPoint.getElevation()
        }
        
        // Add the analysis point
        self.analysisTrackPoints.append(tmpAnalysisTrackPoint)
    }
    
}
