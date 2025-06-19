//
//  Double.swift
//  monkeycrypto
//
//  Created by Matthew Fang on 6/18/25.
//

import Foundation

extension Double {
    func truncate(places: Int) -> String {
        return String(format: "%.\(places)f", self)
    }
    
    func asPercent() -> String {
        return String(self.truncate(places: 2)) + "%"
    }
}
