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
                targetLineColour: Color?,
                requiredItems: [Bool]) {

        var labels = [String]()
        var data = [Double?]()
        
        for dataPoint in timeSeries {
            labels.append(dataPoint.0)
            data.append(dataPoint.1 ?? nil)
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
        
        let requiredItems = [
            true, true, false, true, true, true, true
        ]
        
        BarChartView(mode: .countUp,
                    timeSeries: [("M", 10), ("T", 2), ("W", 10), ("T", 6) , ("F", 7), ("S", 25), ("S", 5)],
                     targetValue: 10,
                     unitText: nil,
                     title: "Test graph",
                     accentColour: .orange,
                     targetLineColour: .gray,
                     requiredItems: requiredItems)
            .previewLayout(.fixed(width: 250, height: 220))
            .padding()
        
        BarChartView(mode: .countUp,
                     timeSeries: [("M", 5), ("T", 3), ("W", 5), ("T", 5) , ("F", 4), ("S", 2), ("S", 4)],
                     targetValue: 5,
                     unitText: nil,
                     title: "Test graph (bug)",
                     accentColour: .orange,
                     targetLineColour: .gray,
                     requiredItems: requiredItems)
            .previewLayout(.fixed(width: 250, height: 220))
            .padding()
        
        BarChartView(mode: .countDown,
                     timeSeries: [("M", nil), ("T", nil), ("W", 1), ("T", 0) , ("F", 2), ("S", 0), ("S", 0)],
                     targetValue: 2,
                     unitText: nil,
                     title: "Test graph (count down)",
                     accentColour: .orange,
                     targetLineColour: .gray,
                     requiredItems: requiredItems)
            .previewLayout(.fixed(width: 250, height: 220))
            .padding()
    }
}
