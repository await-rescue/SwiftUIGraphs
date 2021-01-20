//
//  File.swift
//  
//
//  Created by Ben Gomm on 18/01/2021.
//

import SwiftUI

@available(iOS 13.0, *)
struct BarChartLabel: View {
    let label: String
    let width: Float
    
    let numberOfDataPoints: Int
    var cellWidth: Double {
        return Double(width) / (Double(numberOfDataPoints) * 1.5)
    }
    
    var body: some View {
        Text(label)
            .font(.system(.footnote))
            .frame(minWidth: CGFloat(cellWidth), maxWidth: CGFloat(cellWidth))
    }
}
