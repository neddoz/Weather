//
//  Utilities.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 12/11/2022.
//

import Foundation

// formatters
let dayFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateFormat = "dd"
  return formatter
}()

let monthFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateFormat = "MMMM"
  return formatter
}()

// Date
extension Date {
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfTheWeekString = dateFormatter.string(from: self)
        return dayOfTheWeekString
    }
}

// Arrays
public extension Array where Element: Hashable {
    func removeDuplicates() -> [Element] {
    var seen = Set<Element>()
    return self.filter{ seen.insert($0).inserted }
  }
}
