//
//  Time.swift
//  Reciplease
//
//  Created by rochdi ben abdeljelil on 03.08.2020.
//  Copyright © 2020 rochdi ben abdeljelil. All rights reserved.
//

import Foundation

// MARK: Extension to convert Int to time in String

extension Int {
    
    /// Convert Int to time in String
    var convertIntToTime: String {
        if self == 0 {
            let timeNull = "NA"
            return timeNull
        } else {
            let minutes = self % 60
            let hours = self / 60
            let timeFormatString = String(format: "%01dh%02d", hours, minutes)
            let timeFormatStringMin = String(format: "%02dm", minutes)
            let timeFormatNoMin = String(format: "%01dh", hours)
            let timeFormatStringLessTenMin = String(format: "%01dm", minutes)
            if self < 60 {
                if minutes < 10 {
                return timeFormatStringLessTenMin
                }
                return timeFormatStringMin
            } else if minutes == 0 {
                return timeFormatNoMin
            } else {
                return timeFormatString
            }
        }
    }
}
