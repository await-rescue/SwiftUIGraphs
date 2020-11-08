//
//  BarChartBar.swift
//  
//
//  Created by Ben Gomm on 08/11/2020.
//

import SwiftUI

@available(iOS 13.0, *)
struct BarChartBar: View {
    var value: Double
    var label: String?
    let accentColor: Color
    
    let width: Float
    let numberOfDataPoints: Int
    var cellWidth: Double {
        return Double(width) / (Double(numberOfDataPoints) * 1.5)
    }
    
    @State private var scaleValue: Double = 0
    
    var body: some View {
        ZStack {
            VStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(accentColor)
                    .scaleEffect(CGSize(width: 1, height: scaleValue), anchor: .bottom)
                
                if let label = label {
                    Text(label)
                        .font(.footnote)
                }
            }
        }
        .frame(width: CGFloat(cellWidth))
        .onAppear {
            scaleValue = value
        }.animation(Animation.spring().delay(0.3))
    }
}
