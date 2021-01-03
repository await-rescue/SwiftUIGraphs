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
    var targetValue: Double?
    var labels: [String]?
    var accentColor: Color
    
    var maxValue: Double {
        guard let max = data.max() else { return 1 }
        
        if let targetValue = targetValue {
            // Return whichever is the highest between max and target val
            return targetValue < max ? max : targetValue
        } else {
            return max > 0 ? max : 1
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
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
                
                VStack {
                    Spacer()
                    Rectangle()
                        .frame(height: 1)
                    Spacer()
                        .frame(height: CGFloat(normalizedValue(value: targetValue ?? maxValue, maxValue: maxValue, heightAvailable: geometry.size.height)))
                }
            }
        }
    }
    
    func normalizedValue(index: Int) -> Double {
        Double(self.data[index])/Double(self.maxValue)
    }
    
    func normalizedValue(value: Double, maxValue: Double, heightAvailable: CGFloat) -> Double {
        (value/maxValue) * Double(heightAvailable)
    }
}
