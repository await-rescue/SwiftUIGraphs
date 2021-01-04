//
//  Created by Ben Gomm on 04/01/2021.
//

import Foundation

extension Double {
    func round(places: Int) -> String {
        var places = places
        
        // We do not want decimal places if number is whole
        if floor(self) == self {
            places = 0
        }
        
        return String(format: "%.\(places)f", self)
    }
}
