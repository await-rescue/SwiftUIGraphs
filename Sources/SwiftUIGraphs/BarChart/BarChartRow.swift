//
//  BarChartRow.swift
//  
//
//  Created by Ben Gomm on 08/11/2020.
//

import SwiftUI

@available(iOS 13.0, *)
struct BarChartRow: View {
    var data: [Double]
    var labels: [String]?
    var accentColor: Color
    
    var maxValue: Double {
        guard let max = data.max() else { return 1 }
        return max > 0 ? max : 1
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack(alignment: .bottom,
                       spacing: (geometry.frame(in: .local).width) / CGFloat(self.data.count * 5)) {
                    
                    if let labels = labels {
                        ForEach(0..<self.data.count, id: \.self) { index in
                            BarChartBar(
                                value: normalizedValue(index: index),
                                label: labels[index],
                                accentColor: accentColor,
                                width: Float(geometry.frame(in: .local).width),
                                numberOfDataPoints: data.count)
                        }
                    } else {
                        ForEach(0..<self.data.count, id: \.self) { index in
                            BarChartBar(
                                value: normalizedValue(index: index),
                                accentColor: accentColor,
                                width: Float(geometry.frame(in: .local).width),
                                numberOfDataPoints: data.count)
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    #warning("Make this an extension for a given max value, then we can use for the target value")
    func normalizedValue(index: Int) -> Double {
        return Double(self.data[index])/Double(self.maxValue)
    }
}
