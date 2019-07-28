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
    
    
    func processSAX()->GPSTrack {
        
        class xmlParserDelegate:NSObject, XMLParserDelegate {
            
            var in_gpx=false
            var in_ele=false
            var in_trk=false
            var in_time=false
            var in_name=false
            var in_trkseg=false
            var in_trkpt = false
            let tmpGPSTrack: GPSTrack = GPSTrack()
            let tmpGPSPoint : GPSPoint = GPSPoint()
            
            func parser(_ parser: XMLParser,
                        didStartElement elementName: String,
                        namespaceURI: String?, qualifiedName qName: String?,
                        attributes attributeDict: [String : String] = [:]){
                
                switch elementName
                {
                case "gpx" : print("* gpx start element", elementName)
                case "trk" : print("* trk start element", elementName)
                case "name" : do {
                    print("* name start element", elementName)
                    self.in_name = true
                    }
                case "trkseg" : do {
                    print("* trkseg start element", elementName)
                    self.in_trkseg = true
                    }
                case "trkpt" : do {
                    print("* trkpt start element", elementName)
                    self.in_trkpt = true
                    }
                case "ele" : do {
                    print("* ele start element", elementName)
                    self.in_ele = true
                    }
                case "time" : do {
                    print("* time start element", elementName)
                    self.in_time = true
                    }
                default : print("* UNKNOWN element", elementName)
                }
                
                //Attribute
                for (name,val) in attributeDict
                {
                    if (in_trkpt == true)
                    {
                        switch name
                        {
                        case "lat" : tmpGPSPoint.setLatitude(latitude: (val as NSString).doubleValue )
                        case "lon" : tmpGPSPoint.setLongitude(longitude: (val as NSString).doubleValue)
                        default : print("** unknown attribute", name)
                        }
                    }
                }
            }
            
            func parser(_ parser: XMLParser,
                        didEndElement elementName: String,
                        namespaceURI: String?, qualifiedName qName: String?){
                
                switch elementName
                {
                case "gpx" : print("*** gpx end element", elementName)
                case "trk" : print("*** trk end element", elementName)
                case "name" : do {
                    print("*** name end element", elementName)
                    self.in_name = false
                    }
                case "trkseg" : do {
                    print("*** trkseg end element", elementName)
                    self.in_trkseg = false
                    }
                case "trkpt" : do {
                    print("*** trkpt end element", elementName)
                    self.in_trkpt = false
                    tmpGPSTrack.addTrackPoint(aTrackPoint: tmpGPSPoint)
                    }
                case "ele" : do {
                    print("*** ele end element", elementName)
                    self.in_ele = false
                    }
                case "time" : do {
                    print("*** time end element", elementName)
                    self.in_time = false
                    }
                default : print("*** UNKNOWN end element", elementName)
                }
            }
            
            func parser(_ parser: XMLParser,
                        foundCharacters string: String){
                let s=string.trimmingCharacters(in: .whitespacesAndNewlines)
                if s.count>0
                {
                    if (in_name == true)
                    {
                        tmpGPSTrack.setTrackName(trackname: s)
                        print("** course name", s)
                    }
                    
                    if (in_ele == true)
                    {
                        tmpGPSPoint.setElevation(elevation: (s as NSString).doubleValue )
                        print("** elevation",s)
                    }
                    
                    if (in_time == true)
                    {
                        print("** time",s)
                    }
                    
                }
                //lastNodeWasText=true
            }
            
            public func parserDidEndDocument(_ parser: XMLParser){
                print ("**** End of document")
            }
            
            func parser(_ parser: XMLParser,
                        parseErrorOccurred parseError: Error){
                print("** parseErrorOccurred:\(parseError)")
            }
            
            func parser(_ parser: XMLParser,
                        validationErrorOccurred validationError: Error){
                print("** validationErrorOccurred:\(validationError)")
            }
        }
        
        let myDelegate=xmlParserDelegate()
        let parser=XMLParser(data: GPXFileContent.data(using: .utf16)!)
        parser.delegate = myDelegate
        parser.parse()
        return myDelegate.tmpGPSTrack
    }
    
    func InternalReadFromFile ()
    {
        if let tmpfilepath = Bundle.main.path(forResource: "Test 32K Loop", ofType: "gpx")
        {
            do {
                let contents = try String(contentsOfFile: tmpfilepath)
                print("In Read", tmpfilepath)
                GPXFileContent = contents
                GPXTrack = processSAX()
            } catch {
                // contents could not be loaded
                GPXFileContent = ""
            }
        } else {
            // example.txt not found!
            GPXFileContent = ""
        }
    }
    
    func ReadFromFile(filePath: String)
    {
        do {
            let contents = try String(contentsOfFile: filePath)
                print("In Read", filePath)
                GPXFileContent = contents
                GPXTrack = processSAX()
            } catch {
                 //contents could not be loaded
                GPXFileContent = ""
            }
    }
    
}
