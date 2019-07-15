//
//  ViewController.swift
//  CourseProfiler
//
//  Created by Shaw Goodwin on 13/07/2019.
//  Copyright © 2019 Shaw Goodwin. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    let tmpGPXFile = GPXFile()
    let tmpAnalysisTrack = AnalysisTrack()
    
    @IBOutlet weak var lblOutput: UILabel!
    
    func readGPXFile()
    {
        //let tmpGPXFile = GPXFile()
        lblOutput.text! += "\n Reading XML File"
        tmpGPXFile.readGPXXMLFile(filePath: "https://www.ukcyclingevents.co.uk/maps/gpx/new-forest-100-2019-epic.gpx")
        lblOutput.text! += "\n Parsing XML File"
        tmpGPXFile.parseGPXFileContent()
    }
    
    @IBAction func btnTryItOut(_ sender: Any)
    {
        readGPXFile()
        tmpAnalysisTrack.analyseGPXTrack(aGPXFile: tmpGPXFile)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

