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
    var labels: [String]?
    let title: String
    
    public init(timeSeries: [(String, Double)], title: String) {
        var labels = [String]()
        var data = [Double]()
        
        for dataPoint in timeSeries {
            labels.append(dataPoint.0)
            data.append(dataPoint.1)
        }
        
        self.labels = labels
        self.data = data
        self.title = title
    }
    
    public init(data: [Double], title: String) {
        self.data = data
        self.title = title
    }
    
    public var body: some View {
        ZStack {
            VStack {
                Text(title)
                BarChartRow(data: data, labels: labels, accentColor: .pink)
            }
        }
    }
}
