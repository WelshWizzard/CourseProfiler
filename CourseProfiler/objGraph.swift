//
//  objGraph.swift
//  CourseProfiler
//
//  Created by Shaw Goodwin on 15/07/2019.
//  Copyright © 2019 Shaw Goodwin. All rights reserved.
//

import UIKit

class objGraph: UIView
{
    var tmpAnalysisTrack: AnalysisTrack = AnalysisTrack()
    var tmpstartingposition: Int = 0
    var tmpscaling: Int = 0
    var tmpColourArray = [CGColor]()
    var YScaling: Double = 0.0
    var YOffset: Int = 0
    var XScaling: Double = 0.0
    var XOffset: Int = 0
    var XWidth: CGFloat = 1.0
    
//    init() {
//        super.init(self)
//        self.setupSlopeColours()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func loadAnalysisTrack (tmpAnalysisTrack: AnalysisTrack)
    {
            self.tmpAnalysisTrack = tmpAnalysisTrack
    }
    
    func startingposition (position: Int)
    {
        tmpstartingposition = position
    }
    
    func graphscaling (scaling: Int)
    {
        tmpscaling = scaling
    }
    
    func setupSlopeColours()
    {
        tmpColourArray = []
        
        tmpColourArray.append(UIColor(red: 48/255, green: 48/255, blue: 212/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 48/255, green: 49/255, blue: 226/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 47/255, green: 75/255, blue: 223/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 48/255, green: 126/255, blue: 231/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 49/255, green: 151/255, blue: 232/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 54/255, green: 175/255, blue: 234/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 48/255, green: 201/255, blue: 237/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 52/255, green: 225/255, blue: 238/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 57/255, green: 235/255, blue: 235/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 78/255, green: 229/255, blue: 230/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 98/255, green: 223/255, blue: 222/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 119/255, green: 217/255, blue: 215/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 136/255, green: 211/255, blue: 209/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 126/255, green: 207/255, blue: 175/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 88/255, green: 210/255, blue: 112/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 51/255, green: 212/255, blue: 49/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 113/255, green: 210/255, blue: 88/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 174/255, green: 210/255, blue: 126/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 210/255, green: 211/255, blue: 135/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 217/255, green: 217/255, blue: 118/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 222/255, green: 224/255, blue: 95/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 229/255, green: 229/255, blue: 79/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 235/255, green: 236/255, blue: 61/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 237/255, green: 226/255, blue: 47/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 237/255, green: 201/255, blue: 53/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 235/255, green: 176/255, blue: 55/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 233/255, green: 151/255, blue: 48/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 233/255, green: 123/255, blue: 49/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 225/255, green: 62/255, blue: 2/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 223/255, green: 34/255, blue: 2/255, alpha: 1.0).cgColor)
        tmpColourArray.append(UIColor(red: 99/255, green: 0, blue: 0, alpha: 1.0).cgColor)
    }
    
    func slopetocolour(slope: Int) -> CGColor
    {
        if slope < -15 {
            // Max -15 slope
            return tmpColourArray[0]
        } else if slope > 15
            {
                // Max 15 slope
                return tmpColourArray[30]
        } else {
            return tmpColourArray[slope+15]
        }
    }
    
    func setYScaling(context: CGRect)
    {
        // Add 20% - 10% on bottom and 10% on top
        YScaling = Double(context.size.height) / ((tmpAnalysisTrack.analysisMaxElevation - tmpAnalysisTrack.analysisMinElevation) * 1.2)
        YOffset = Int(((tmpAnalysisTrack.analysisMinElevation) * 0.9) * YScaling)
        
    }
    
    func setXScaling(context: CGRect)
    {

            XScaling = Double(tmpAnalysisTrack.analysisTrackPoints.count) / Double(context.size.width)
            XScaling *= (Double(tmpscaling) / 100.0)
            XScaling += 1

        XOffset = ((tmpAnalysisTrack.analysisTrackPoints.count - Int(context.size.width)) * tmpstartingposition / 100)
    }
    
    public override func draw(_ rect: CGRect)
    {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        if (tmpAnalysisTrack.analysisTrackPoints.count) == 0
        {
            // Track has been loaded
            setupSlopeColours()
        }
        else
        {
            setYScaling(context: rect)
            setXScaling(context: rect)
            
            context.setLineWidth(XWidth)
            
            for i in 0..<Int(rect.size.width)
            {
                if (Int(Double(i) * XScaling) + XOffset) < tmpAnalysisTrack.analysisTrackPoints.count
                {
                    context.move(to: CGPoint(x: i, y: Int(rect.size.height)))
                    context.setStrokeColor( slopetocolour(slope: Int(tmpAnalysisTrack.analysisTrackPoints[(Int(Double(i) * XScaling) + XOffset)].getslope())) )
                    context.addLine(to: CGPoint(x: i, y: Int(rect.size.height) - Int(( tmpAnalysisTrack.analysisTrackPoints[(Int(Double(i) * XScaling) + XOffset)].getElevation()) * YScaling) + YOffset ))
                    
                    context.strokePath()
                }

            }
        }
    }

}
