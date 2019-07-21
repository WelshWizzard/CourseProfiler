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
    var ascent: Double = 0.0
    var decent: Double = 0.0
    var analysisTrackPoints: [AnalysisPoint] = []
    let analysisPrecision: Double = 1.0
    
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
        
        if aAnalysisTrackPoint.elevationDifference > 0
        {
            ascent += aAnalysisTrackPoint.elevationDifference
        } else
        {
            decent += aAnalysisTrackPoint.elevationDifference
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
 
    func appendanalysispoint (aAnalysisPoint: AnalysisPoint)
    {
        let tmpAnalysisTrackPoint: AnalysisPoint = AnalysisPoint()
        
        tmpAnalysisTrackPoint.distanceBetween = aAnalysisPoint.distanceBetween
        tmpAnalysisTrackPoint.elevationDifference = aAnalysisPoint.elevationDifference
        tmpAnalysisTrackPoint.slope = aAnalysisPoint.slope
        tmpAnalysisTrackPoint.elevation = aAnalysisPoint.elevation
        tmpAnalysisTrackPoint.latitude = aAnalysisPoint.latitude
        tmpAnalysisTrackPoint.longitude = aAnalysisPoint.longitude

        self.analysisTrackPoints.append(tmpAnalysisTrackPoint)
    }
    
    func addAnalysisTrackPoint (aAnalysisTrackPoint: GPSPoint)
    {
        let tmpAnalysisTrackPoint : AnalysisPoint = AnalysisPoint()
        var tmpDistanceBetween : Double = 0.0
        var tmpSlopeBetween : Double = 0.0
        var tmpElevationBetween : Double = 0.0
        var tmpElevationperprecision : Double = 0.0
        var tmplastanalysisPoint : Int = 0
        
        // Set local AnalysisPoint to passed through GPSPoint
        tmpAnalysisTrackPoint.setGPSPoint(longitude: aAnalysisTrackPoint.getLongitude(), latitude: aAnalysisTrackPoint.getLatitude(), elevation: aAnalysisTrackPoint.getElevation())
  
        // Check if it is the first analysis point
        if self.analysisTrackPoints.count > 0
        {
            // Work out subscript of the last trackpoint
            tmplastanalysisPoint = self.analysisTrackPoints.count - 1
            
            // Calculate distance between last analysis point and new GPX Point
            tmpDistanceBetween = self.analysisTrackPoints[tmplastanalysisPoint].distancefromnanotherpoint(to: tmpAnalysisTrackPoint)
            
            //Calculate elevation difference
            tmpElevationBetween = self.analysisTrackPoints[tmplastanalysisPoint].elevationdifferencefromanotherpoint(to: tmpAnalysisTrackPoint)
            
            //Calculate the slope between both points
            tmpSlopeBetween = (tmpElevationBetween / tmpDistanceBetween) * 100.0

            //Work out the evevation change over the analysisPrecision distance
            tmpElevationperprecision = (analysisPrecision / tmpDistanceBetween) * tmpElevationBetween
        
            while tmpDistanceBetween > analysisPrecision
            {
                // If it is not the first then calculate
                tmpAnalysisTrackPoint.distanceBetween = analysisPrecision
                tmpAnalysisTrackPoint.slope = 0 - tmpSlopeBetween
                tmpAnalysisTrackPoint.elevation = self.analysisTrackPoints[tmplastanalysisPoint].elevation - tmpElevationperprecision
                tmpAnalysisTrackPoint.elevationDifference = 0 - tmpElevationperprecision

                updateAnalysisSummaries(aAnalysisTrackPoint: tmpAnalysisTrackPoint)
                appendanalysispoint(aAnalysisPoint: tmpAnalysisTrackPoint)
                
                tmpDistanceBetween -= analysisPrecision
                tmplastanalysisPoint += 1
            }
        }
        else
        {
            //First point so manually set analysis summary points
            self.analysisMaxElevation = aAnalysisTrackPoint.getElevation()
            self.analysisMinElevation = aAnalysisTrackPoint.getElevation()
            self.analysisTrackPoints.append(tmpAnalysisTrackPoint)
        }
    }
    
}
