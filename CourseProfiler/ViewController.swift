//
//  ViewController.swift
//  CourseProfiler
//
//  Created by Shaw Goodwin on 13/07/2019.
//  Copyright © 2019 Shaw Goodwin. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UITableViewDataSource
{
    let tmpGPXFile = GPXFile()
    let tmpAnalysisTrack = AnalysisTrack()
    private var tmpdata: [String] = []
    
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
        // New Code
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeContent as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
    
    //FromWWeb Button
    @IBAction func btnTryItOut(_ sender: Any)
    {
        // Read GPX from internal bundle
        tmpGPXFile.GPXFileContent.removeAll(keepingCapacity: false)
        tmpAnalysisTrack.empty()
        tmpGPXFile.InternalReadFromFile()
        tmpAnalysisTrack.analyseGPXTrack(aGPXFile: tmpGPXFile)
        graphOutput.loadAnalysisTrack(tmpAnalysisTrack: tmpAnalysisTrack)
        graphOutput.setNeedsDisplay()
        updateCourseStats()
    }
    
    //Tableview for Ride Info
    @IBOutlet weak var statsTableView: UITableView!
    
    func updateCourseStats()
    {
        tmpdata.removeAll(keepingCapacity: false)
        if tmpAnalysisTrack.analysisTrackPoints.count > 0
        {
            //We have loaded the analysis file
            tmpdata.append("Track Name : \(tmpAnalysisTrack.analysisTrackName)")
            tmpdata.append("Course Distance : \(String(format: "%.3f", tmpAnalysisTrack.analysisTrackDistance/1000)) Km")
            tmpdata.append("Course Difficulty : \(String(format: "%.1f", tmpAnalysisTrack.difficulty/1000))")
            tmpdata.append("Min Slope : \(String(format: "%.1f",tmpAnalysisTrack.analysisMinSlope))% Max Slope : \(String(format: "%.1f",tmpAnalysisTrack.analysisMaxSlope))%")
            tmpdata.append("Min Ele. : \(String(format: "%.1f",tmpAnalysisTrack.analysisMinElevation))m Max Ele. : \(String(format: "%.1f",tmpAnalysisTrack.analysisMaxElevation))m")
            tmpdata.append("Decend : \(String(format: "%.1f",tmpAnalysisTrack.decent))m Ascent. : \(String(format: "%.1f",tmpAnalysisTrack.ascent))m")
        } else
        {
            //We haven't got an analysis Track
            tmpdata.append("No analysis - no track loaded")
        }
        statsTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateCourseStats()
        statsTableView.dataSource = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tmpdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")!
        let text = tmpdata[indexPath.row]
        cell.textLabel?.text = text
        return cell
    }

}

//New Code
extension ViewController: UIDocumentPickerDelegate
{
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL])
    {
        guard let selectedFileURL = urls.first
            else {
                    return
                }
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = dir.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            print("Already exists! Do nothing")
        }
        else {

            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                print("Copied file!")
            }
            catch {
                print("Error: \(error)")
            }
        }
        tmpGPXFile.GPXFileContent.removeAll(keepingCapacity: false)
        tmpAnalysisTrack.empty()
        tmpGPXFile.ReadFromFile(filePath: sandboxFileURL.path)
        tmpAnalysisTrack.analyseGPXTrack(aGPXFile: tmpGPXFile)
        graphOutput.loadAnalysisTrack(tmpAnalysisTrack: tmpAnalysisTrack)
        graphOutput.setNeedsDisplay()
        updateCourseStats()
    }
}

