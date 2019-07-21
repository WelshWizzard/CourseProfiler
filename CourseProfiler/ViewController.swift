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

    
    // Graph Output area
    @IBOutlet weak var graphOutput: objGraph!
    
    // Scale Slider
    @IBOutlet weak var sldrScale: UISlider!
    @IBAction func mysldrScaleChanged(_ sender: UISlider) {
        graphOutput.graphscaling(scaling: Int(sender.value))
        graphOutput.setNeedsDisplay()
    }
    
    // Start Position Slider
    @IBOutlet weak var myslider: UISlider!
    @IBAction func mysliderchanged(_ sender: UISlider)
    {
        graphOutput.startingposition(position: Int(sender.value))
        graphOutput.setNeedsDisplay()
        
    }
 
    // Status Label
    @IBOutlet weak var myStatusLabel: UILabel!
    func statusUpdate(mystring : String)
    {
        myStatusLabel.text = mystring
        myStatusLabel.setNeedsDisplay()
        
        print(mystring)
    }
    
    // FromFile Button
    @IBAction func btnLoadFromFile(_ sender: Any) {
        // Read GPX from Web
        statusUpdate(mystring: "Read GPX file from WEB")
        myStatusLabel.setNeedsDisplay()
        tmpGPXFile.tstReadfromFile()
        statusUpdate(mystring: "Parse the GPX file")
        tmpGPXFile.parseGPXFileContent()
        statusUpdate(mystring: "GPX to Analysis")
        tmpAnalysisTrack.analyseGPXTrack(aGPXFile: tmpGPXFile)
        graphOutput.loadAnalysisTrack(tmpAnalysisTrack: tmpAnalysisTrack)
        graphOutput.setNeedsDisplay()
    }
    
    //FromWWeb Button
    @IBAction func btnTryItOut(_ sender: Any)
    {
        // Read GPX from Web
        statusUpdate(mystring: "Read GPX file from WEB")
        myStatusLabel.setNeedsDisplay()
        tmpGPXFile.tstReadfromWeb(filePath: "https://www.ukcyclingevents.co.uk/maps/gpx/new-forest-100-2019-epic.gpx")
        statusUpdate(mystring: "Parse the GPX file")
        tmpGPXFile.parseGPXFileContent()
        
        
        tmpAnalysisTrack.analyseGPXTrack(aGPXFile: tmpGPXFile)
        graphOutput.loadAnalysisTrack(tmpAnalysisTrack: tmpAnalysisTrack)
        graphOutput.setNeedsDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

