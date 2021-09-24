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
    let required: Bool
    let accentColor: Color
    let cornerRadius: Double
    
    let width: Float
    let numberOfDataPoints: Int
    var cellWidth: Double {
        return Double(width) / (Double(numberOfDataPoints) * 1.5)
    }
    
    @State private var scaleValue: Double = 0
    
    var body: some View {
        ZStack {
            VStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(required == true ? accentColor : Color.gray)
                    .opacity(required == true ? 1 : 0.5)
                    .scaleEffect(CGSize(width: 1, height: scaleValue), anchor: .bottom)
            }
        }
        .frame(width: CGFloat(cellWidth))
        .onAppear {
            withAnimation(.spring().delay(0.4)) {
                scaleValue = value
            }
        }
    }
}
