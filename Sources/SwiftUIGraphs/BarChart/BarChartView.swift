//
//  BarChart.swift
//  
//
//  Created by Ben Gomm on 08/11/2020.
//

import SwiftUI

@available(iOS 13.0, *)
public struct BarChartView: View {
    var data: [Double]
    let targetValue: Double?
    let unitText: String?
    var labels: [String]?
    let title: String
    let accentColour: Color
    
    public init(timeSeries: [(String, Double)], targetValue: Double?, unitText: String, title: String, accentColour: Color) {
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
    }
    
    public init(data: [Double], targetValue: Double?, unitText: String, title: String, accentColour: Color) {
        self.data = data
        self.targetValue = targetValue
        self.unitText = unitText
        self.title = title
        self.accentColour = accentColour
    }
    
    public var body: some View {
        ZStack {
            VStack {
                Text(title)
                    .font(.footnote)
                BarChartRow(data: data, targetValue: targetValue, unitText: unitText, labels: labels, accentColor: accentColour)
            }
        }
    }
}
