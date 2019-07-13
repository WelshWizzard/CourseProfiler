//
//  clsGPXFileParse.swift
//  CourseProfiler
//
//  Created by Shaw Goodwin on 13/07/2019.
//  Copyright © 2019 Shaw Goodwin. All rights reserved.
//
//
// Class to hold a coordinate
// 1.0 Initial implementation

import Foundation

class GPXFile{
    var GPXFileContent: String = ""
    var GPXTrack: GPSTrack = GPSTrack()
    
    func parseGPXSection() -> String {
        var tmpStr = ""
        var inSection = false
        var filePosition = 0
        
        for chars in GPXFileContent
        {
            filePosition += 1
            if filePosition == 1 {
                //first character of the string
                if chars == "<" {
                    inSection = true
                }
                else {
                    inSection = false
                    tmpStr.append(chars)
                }
            } else {
                if inSection == true {
                    if chars == ">" {
                        //Got to the end of the inSection
                        GPXFileContent.removeFirst(filePosition)
                        return tmpStr
                    } else {
                        // still in inSection
                        tmpStr.append(chars)
                    }
                } else {
                    if chars == "<" {
                        //Got to the start of a new inSection - dont remove the <
                        GPXFileContent.removeFirst(filePosition-1)
                        return tmpStr
                    } else {
                        // Still out of section
                        tmpStr.append(chars)
                    }
                }
            }
            
        }
        // Got here as we have got to the end of the file
        GPXFileContent.removeAll()
        return tmpStr
    }
    
    func extractLat (tmpString: String) -> Double {
        var extractedString : String = ""
        var numberofquotes = 0
        
        for chars in tmpString{
            if chars == "\"" {
                numberofquotes += 1
            } else {
                if numberofquotes == 1 {
                    extractedString.append(chars)
                }
            }
        }
        return  (extractedString as NSString).doubleValue
    }
    
    func extractLon (tmpString: String) -> Double {
        var extractedString : String = ""
        var numberofquotes = 0
        
        for chars in tmpString{
            if chars == "\"" {
                numberofquotes += 1
            } else {
                if numberofquotes == 3 {
                    extractedString.append(chars)
                }
            }
        }
        return  (extractedString as NSString).doubleValue
    }
    
    func checkforSection (tmpString : String, sectiontype: String) -> Bool {
        if tmpString.hasPrefix(sectiontype) == true {
            return true
        } else {
            return false
        }
    }
    
    func parseGPXFileContent() {
        var tmpString : String = ""
        var intrkSection : Bool = false
        var innameSection : Bool = false
        var intrksegSection : Bool = false
        var ineleSection : Bool = false
        var intimeSection : Bool = false
        let tmpGPSPoint : GPSPoint = GPSPoint()
        
        while GPXFileContent.count > 0 {
            // Parse next section of the files stored in the string
            tmpString = parseGPXSection()
            
            if intrkSection == false {
                // Not in a trk section so loop around until we are
                if checkforSection(tmpString: tmpString, sectiontype: "trk") == true {
                    intrkSection = true
                }
            } else {
                // In trk Section
                // Check if in a trkseg section
                if intrksegSection == true {
                    //intrkseg Section
                    // Check if we are in elevation section
                    if ineleSection == true {
                        if checkforSection(tmpString: tmpString, sectiontype: "/ele") {
                            ineleSection = false
                        } else {
                            tmpGPSPoint.setElevation(elevation: (tmpString as NSString).doubleValue)
                        }
                    } else if intimeSection == true {
                        if checkforSection(tmpString: tmpString, sectiontype: "/time") {
                            intimeSection = false
                        } else {
                            //Not processing time labels at the moment
                        }
                    } else if checkforSection(tmpString: tmpString, sectiontype: "ele") {
                        ineleSection = true
                    } else if checkforSection(tmpString: tmpString, sectiontype: "time") {
                        intimeSection = true
                    } else if checkforSection(tmpString: tmpString, sectiontype: "trkpt") {
                        tmpGPSPoint.setLatitude(latitude: extractLat(tmpString: tmpString))
                        tmpGPSPoint.setLongitude(longitude: extractLon(tmpString: tmpString))
                    } else if checkforSection(tmpString: tmpString, sectiontype: "/trkpt") {
                        //End of trkpt section
                        GPXTrack.addTrackPoint(aTrackPoint: tmpGPSPoint)
                        print(tmpGPSPoint.getLongitude()," ",tmpGPSPoint.getLatitude()," ",tmpGPSPoint.getElevation())
                    } else {
                        //Must be a blank line
                    }
                } else if innameSection == true {
                    //It will be either /name or the name string between
                    if checkforSection(tmpString: tmpString, sectiontype: "/name") {
                        innameSection = false
                    } else {
                        GPXTrack.setTrackName(trackname: tmpString)
                    }
                } else if checkforSection(tmpString: tmpString, sectiontype: "name") {
                    // start of name section
                    innameSection = true
                } else if checkforSection(tmpString: tmpString, sectiontype: "trkseg") {
                    // start of trkseg section
                    intrksegSection = true
                } else {
                    // must be blank
                }
            }
        }
        print(GPXTrack.getTrackName())
        print(GPXTrack.getTrackPoints().count)
    }
    
    func readGPXXMLFile(filePath: String) {
        //if let url = URL(string: filePath) {
        //    do {
        //        GPXFileContent = try String(contentsOf: url)
        //    } catch {
        //        // contents could not be loaded
        //        GPXFileContent = ""
        //    }
        //} else {
        //    //URL was bad
        //    GPXFileContent = ""
        //}
        if let tmpfilepath = Bundle.main.path(forResource: "Test 32K Loop", ofType: "gpx")
        {
            do {
                let contents = try String(contentsOfFile: tmpfilepath)
                GPXFileContent = contents
            } catch {
                // contents could not be loaded
                GPXFileContent = ""
            }
        } else {
            // example.txt not found!
            GPXFileContent = ""
        }
        
    }
}
