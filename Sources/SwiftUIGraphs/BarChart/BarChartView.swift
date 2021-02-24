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
    let data: [Double?]
    let targetValue: Double?
    let unitText: String?
    var labels: [String]?
    let title: String
    let accentColour: Color
    let targetLineColour: Color?
    let mode: BarGraphMode
    let requiredItems: [Bool]
    
    var targetTextPrefix: String {
        switch mode {
        case .countUp:
            return "Target"
        case .countDown:
            return "Amount left"
        }
    }
    
    public init(mode: BarGraphMode,
                timeSeries: [TimeSeries],
                targetValue: Double?,
                unitText: String?,
                title: String,
                accentColour: Color,
                targetLineColour: Color?) {

        var labels = [String]()
        var data = [Double?]()
        var requiredItems = [Bool]()
        
        for dataPoint in timeSeries {
            labels.append(dataPoint.0)
            data.append(dataPoint.1 ?? nil)
            requiredItems.append(dataPoint.2)
        }
        
        self.mode = mode
        self.labels = labels
        self.data = data
        self.targetValue = targetValue
        self.unitText = unitText
        self.title = title
        self.accentColour = accentColour
        self.targetLineColour = targetLineColour
        self.requiredItems = requiredItems
    }
    
    public var body: some View {

        VStack {
            HStack {
                Text(title)
                    .font(.footnote)
                Spacer()
                if let targetValue = targetValue {
                    Text("\(targetTextPrefix): \(targetValue.round(places: 1)) \(unitText ?? "")")
                        .font(.footnote)
                }
            }
            
            BarChartRow(mode: mode, data: data, targetValue: targetValue,
                        unitText: unitText, labels: labels, accentColor: accentColour,
                        targetLineColour: targetLineColour, requiredItems: requiredItems)
        }
    }
}


struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        
        BarChartView(mode: .countUp,
                    timeSeries: [("M", 10, true), ("T", 2, true), ("W", 10, false), ("T", 6, true) , ("F", 7, true), ("S", 25, true), ("S", 5, true)],
                     targetValue: 10,
                     unitText: nil,
                     title: "Test graph",
                     accentColour: .orange,
                     targetLineColour: .gray)
            .previewLayout(.fixed(width: 250, height: 220))
            .padding()
        
        BarChartView(mode: .countUp,
                     timeSeries: [("M", 5, false), ("T", 3, true), ("W", 5, true), ("T", 5, true) , ("F", 4, true), ("S", 2, true), ("S", 4, true)],
                     targetValue: 5,
                     unitText: nil,
                     title: "Test graph (bug)",
                     accentColour: .orange,
                     targetLineColour: .gray)
            .previewLayout(.fixed(width: 250, height: 220))
            .padding()
        
        BarChartView(mode: .countDown,
                     timeSeries: [("M", nil, false), ("T", nil, true), ("W", 1, true), ("T", 0, true) , ("F", 2, true), ("S", 0, true), ("S", 0, true)],
                     targetValue: 2,
                     unitText: nil,
                     title: "Test graph (count down)",
                     accentColour: .orange,
                     targetLineColour: .gray)
            .previewLayout(.fixed(width: 250, height: 220))
            .padding()
    }
}
