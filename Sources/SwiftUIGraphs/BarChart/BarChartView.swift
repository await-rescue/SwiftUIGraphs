//
//  BarChart.swift
//  
//
//  Created by Ben Gomm on 08/11/2020.
//

import SwiftUI

public enum BarGraphMode {
    case countDown, countUp
}

@available(iOS 13.0, *)
public struct BarChartView: View {
    let data: [Double]
    let targetValue: Double?
    let unitText: String?
    var labels: [String]?
    let title: String
    let accentColour: Color
    let targetLineColour: Color?
    let mode: BarGraphMode
    
    var targetTextPrefix: String {
        switch mode {
        case .countUp:
            return "Target"
        case .countDown:
            return "Limit"
        }
    }
    
    public init(mode: BarGraphMode,
                timeSeries: [(String, Double)],
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
        self.mode = mode
        self.labels = labels
        self.data = data
        self.targetValue = targetValue
        self.unitText = unitText
        self.title = title
        self.accentColour = accentColour
        self.targetLineColour = targetLineColour
    }
    
    public init(mode: BarGraphMode,
                data: [Double],
                targetValue: Double?,
                unitText: String?,
                title: String,
                accentColour: Color,
                targetLineColour: Color?) {
        
        self.mode = mode
        self.data = data
        self.targetValue = targetValue
        self.unitText = unitText
        self.title = title
        self.accentColour = accentColour
        self.targetLineColour = targetLineColour
    }
    
    public var body: some View {

        VStack {
            HStack {
                Text(title)
                    .font(.footnote)
                Spacer()
                if let targetValue = targetValue {
                    Text("\(targetTextPrefix): \(targetValue.round(places: 1)) \(unitText ?? "")")
                        .font(.system(size: 8))
                }
            }
            
            BarChartRow(mode: mode, data: data, targetValue: targetValue, unitText: unitText, labels: labels, accentColor: accentColour, targetLineColour: targetLineColour)
        }
    }
}


struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        
        BarChartView(mode: .countUp,
                     data: [1, 0, 0, 1 ,0, 1, 1],
                     targetValue: 1,
                     unitText: "km",
                     title: "Test graph",
                     accentColour: .orange,
                     targetLineColour: .gray)
            .previewLayout(.fixed(width: 250, height: 220))
            .padding()
        
        BarChartView(mode: .countUp,
                     data: [10, 2, 10, 6 ,7, 3, 18],
                     targetValue: 10,
                     unitText: "km",
                     title: "Test graph",
                     accentColour: .orange,
                     targetLineColour: .gray)
            .previewLayout(.fixed(width: 250, height: 220))
            .padding()
        
        BarChartView(mode: .countUp,
                    timeSeries: [("M", 10), ("T", 2), ("W", 10), ("T", 6) , ("F", 7), ("S", 25), ("S", 5)],
                     targetValue: 10,
                     unitText: nil,
                     title: "Test graph",
                     accentColour: .orange,
                     targetLineColour: .gray)
            .previewLayout(.fixed(width: 250, height: 220))
            .padding()
        
        BarChartView(mode: .countUp,
                     timeSeries: [("M", 5), ("T", 3), ("W", 5), ("T", 5) , ("F", 4), ("S", 2), ("S", 4)],
                     targetValue: 5,
                     unitText: nil,
                     title: "Test graph (bug)",
                     accentColour: .orange,
                     targetLineColour: .gray)
            .previewLayout(.fixed(width: 250, height: 220))
            .padding()
        
        BarChartView(mode: .countDown,
                     timeSeries: [("M", 2), ("T", 2), ("W", 1), ("T", 0) , ("F", 2), ("S", 0), ("S", 0)],
                     targetValue: 2,
                     unitText: nil,
                     title: "Test graph (count down)",
                     accentColour: .orange,
                     targetLineColour: .gray)
            .previewLayout(.fixed(width: 250, height: 220))
            .padding()
    }
}
