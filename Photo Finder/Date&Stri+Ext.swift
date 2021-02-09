//
//  String+Ext.swift
//  Photo Finder
//
//  Created by Alex Paul on 2/9/21.
//

import Foundation
extension String{
    
    func trunc(length: Int, trailing: String = "…") -> String {
        return (self.count > length) ? self.prefix(length) + trailing : self
    }

    func convertToDate() -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayFormat()->String{
        guard let date = self.convertToDate()  else { return "N/A"}
        return date.convertToMonthYearFormat()
    }
}

extension Date{
    func convertToMonthYearFormat()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
}
