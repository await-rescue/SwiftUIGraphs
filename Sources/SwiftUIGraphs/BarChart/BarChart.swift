//
//  BarChart.swift
//  
//
//  Created by Ben Gomm on 08/11/2020.
//

import SwiftUI

@available(iOS 13.0, *)
struct BarChart: View {
    var data: [Double]
    var labels: [String]?
    let title: String
    
    init(timeSeries: [TimeSeries], title: String) {
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
    
    init(data: [Double], title: String) {
        self.data = data
        self.title = title
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text(title)
                BarChartRow(data: data, labels: labels, accentColor: .pink)
            }
        }
    }
}
