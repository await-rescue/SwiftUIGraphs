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
                    .fill(required == true ? accentColor : Color.gray)
                    .opacity(required == true ? 1 : 0.5)
                    .scaleEffect(CGSize(width: 1, height: scaleValue), anchor: .bottom)
            }
        }
        .frame(width: CGFloat(cellWidth))
        .onAppear {
            withAnimation(.easeInOut(duration: 0.3).delay(0.3)) {
                scaleValue = value
            }
        }
    }
}
