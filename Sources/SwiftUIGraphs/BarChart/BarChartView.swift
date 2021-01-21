//
//  BarChart.swift
//  
//
//  Created by Ben Gomm on 08/11/2020.
//

import SwiftUI

@available(iOS 13.0, *)
public struct BarChartView: View {
    let data: [Double]
    let targetValue: Double?
    let unitText: String?
    var labels: [String]?
    let title: String
    let accentColour: Color
    let targetLineColour: Color?
    
    public init(timeSeries: [(String, Double)],
                targetValue: Double?,
                unitText: String?,
                title: String,
                accentColour: Color,
                targetLineColour: Color?) {

        var labels = [String]()
        var data = [Double]()
        
        for dataPoint in timeSeries {
            labels.append(dataPoint.0)
            data.append(dataPoint.1)
        }
        
        self.labels = labels
        self.data = data
        self.targetValue = targetValue
        self.unitText = unitText
        self.title = title
        self.accentColour = accentColour
        self.targetLineColour = targetLineColour
    }
    
    public init(data: [Double],
                targetValue: Double?,
                unitText: String?,
                title: String,
                accentColour: Color,
                targetLineColour: Color?) {
        
        self.data = data
        self.targetValue = targetValue
        self.unitText = unitText
        self.title = title
        self.accentColour = accentColour
        self.targetLineColour = targetLineColour
    }
    
    public var body: some View {

        VStack {
            Text(title)
                .font(.footnote)
            
            BarChartRow(data: data, targetValue: targetValue, unitText: unitText, labels: labels, accentColor: accentColour, targetLineColour: targetLineColour)
        }
    }
}


struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        
        BarChartView(data: [10, 2, 10, 6 ,7, 3, 14],
                     targetValue: 10,
                     unitText: "km",
                     title: "Test graph",
                     accentColour: .orange,
                     targetLineColour: .gray)
            .previewLayout(.fixed(width: 250, height: 220))
            .padding()
        
        BarChartView(timeSeries: [("M", 10), ("T", 2), ("W", 10), ("T", 6) , ("F", 7), ("S", 25), ("S", 5)],
                     targetValue: 10,
                     unitText: "km",
                     title: "Test graph",
                     accentColour: .orange,
                     targetLineColour: .gray)
            .previewLayout(.fixed(width: 290, height: 300))
            .padding()
        
    }
}
