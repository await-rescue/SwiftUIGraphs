//
//  BarChartRow.swift
//  
//
//  Created by Ben Gomm on 08/11/2020.
//

import SwiftUI

@available(iOS 13.0, *)
struct TargetValueIndicator: View {
    
    var heightAvailable: CGFloat
    let maxValue: Double
    let targetValue: Double
    let unitText: String?
    let targetLineColour: Color?
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: heightAvailable - getTargetLineHeight(heightAvailable: heightAvailable))
            
            ZStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(targetLineColour ?? .gray)
                    .padding(.horizontal, 5)
                
//                HStack {
//                    Text("\(targetValue.round(places: 1)) \(unitText ?? "")")
//                        .font(.system(size: 8))
//                    Spacer()
//                }
            }

            Spacer()
                .frame(height: getTargetLineHeight(heightAvailable: heightAvailable))
        }
    }
    
    func getTargetLineHeight(heightAvailable: CGFloat) -> CGFloat {
        CGFloat((targetValue/maxValue) * Double(heightAvailable))
    }
}

@available(iOS 13.0, *)
struct BarChartRow: View {
    let mode: BarGraphMode
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
        GeometryReader { geo in
            VStack {
                GeometryReader { innerGeo in
                    ZStack {
                        HStack(alignment: .bottom,
                               spacing: (innerGeo.frame(in: .local).width) / CGFloat(self.data.count * 5)) {
                            
                            ForEach(0..<self.data.count, id: \.self) { index in
                                VStack {
                                    BarChartBar(
                                        value: normalizedValue(index: index),
                                        accentColor: accentColor,
                                        width: Float(innerGeo.frame(in: .local).width),
                                        numberOfDataPoints: data.count)
                                }
                            }
                        }
                        
                        if let targetValue = targetValue {
                            TargetValueIndicator(heightAvailable: innerGeo.size.height, maxValue: maxValue, targetValue: targetValue, unitText: unitText, targetLineColour: .gray)
                        }
                    }
                }
                
                // Hack
                HStack(alignment: .bottom,
                       spacing: (geo.frame(in: .local).width) / CGFloat(self.data.count * 5)) {
                    ForEach(0..<self.data.count, id: \.self) { index in
                        Text("")
                            .font(.system(.caption))
                    }
                }
                
                if let labels = labels {
                    HStack(alignment: .bottom,
                           spacing: (geo.frame(in: .local).width) / CGFloat(self.data.count * 5)) {
                        ForEach(0..<self.data.count, id: \.self) { index in
                            BarChartLabel(label: labels[index], width: Float(geo.frame(in: .local).width), numberOfDataPoints: labels.count)
                        }
                    }
                }
            }
        }
    }
    
    func normalizedValue(index: Int) -> Double {
        let amountDone = Double(self.data[index])/Double(self.maxValue)
        
        switch mode {
        case .countUp:
            return amountDone
        case .countDown:
            return 1 - amountDone
        }
    }
}
