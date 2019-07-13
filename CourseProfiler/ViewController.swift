//
//  ViewController.swift
//  CourseProfiler
//
//  Created by Shaw Goodwin on 13/07/2019.
//  Copyright © 2019 Shaw Goodwin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblOutput: UILabel!
    
    @IBAction func btnTryItOut(_ sender: Any) {
        lblOutput.text = "Shaw was here"
        
        var point1 : GPSPoint = GPSPoint()
        var point2 : GPSPoint = GPSPoint()
        
        let tmpGPXFile = GPXFile()
        lblOutput.text! += "\n Reading XML File"
        tmpGPXFile.readGPXXMLFile(filePath: "https://www.ukcyclingevents.co.uk/maps/gpx/new-forest-100-2019-epic.gpx")
        lblOutput.text! += "\n Parsing XML File"
        tmpGPXFile.parseGPXFileContent()
        
        var distance: Double = 0.0
        
        for i in 0..<tmpGPXFile.GPXTrack.trackpoints.count-1 {
            point1 = tmpGPXFile.GPXTrack.trackpoints[i]
            point2 = tmpGPXFile.GPXTrack.trackpoints[i+1]
            distance += point1.distancetoanotherpoint(to: point2)
        }
        lblOutput.text = String(distance)
        print(distance)    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

