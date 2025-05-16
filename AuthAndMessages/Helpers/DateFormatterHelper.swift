//
//  DateFormatterHelper.swift
//  AuthAndMessages
//
//  Created by Mangust on 16.05.2025.
//

import Foundation

protocol DateFormatterHelperProtocol {
    func parseDate(from dateString: String) -> Date?
}

struct DateFormatterHelper: DateFormatterHelperProtocol {
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        f.locale = Locale(identifier: "en_US_POSIX")
        return f
    }()

    func parseDate(from dateString: String) -> Date? {
        formatter.date(from: dateString)
    }
}
