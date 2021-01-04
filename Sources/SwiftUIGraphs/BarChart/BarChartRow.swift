//
//  BarChartRow.swift
//  
//
//  Created by Ben Gomm on 08/11/2020.
//

import SwiftUI

@available(iOS 13.0, *)
struct BarChartRow: View {
    let data: [Double]
    let targetValue: Double?
    let unitText: String?
    let labels: [String]?
    let accentColor: Color
    let targetLineColour: Color?
    
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
                
                // Target value indicator
                VStack {
                    Spacer()
                        .frame(height: geometry.size.height - getTargetLineHeight(heightAvailable: geometry.size.height) + 1)
                    HStack {
                        VStack {
                            if let targetValue = targetValue {
                                Text(targetValue.round(places: 1))
                            }
                            
                            if let unitText = unitText {
                                Text(unitText)
                            }
                        }
                        .font(.system(size: 8))

                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(targetLineColour ?? .gray)
                            .padding(.horizontal, 5)
                    }
                    Spacer()
                        .frame(height: getTargetLineHeight(heightAvailable: geometry.size.height))
                }
            }
        }
    }
    
    func normalizedValue(index: Int) -> Double {
        Double(self.data[index])/Double(self.maxValue)
    }
    
    func getTargetLineHeight(heightAvailable: CGFloat) -> CGFloat {
        let value = targetValue ?? maxValue
        return CGFloat((value/maxValue) * Double(heightAvailable))
    }
}
