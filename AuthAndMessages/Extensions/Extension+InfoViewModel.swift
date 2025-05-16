//
//  Extension+Array<InfoViewModel>.swift
//  AuthAndMessages
//
//  Created by Mangust on 16.05.2025.
//

import Foundation

extension Array where Element == InfoViewModel {
    func sortedByDateDescending(_ dateFormatter: DateFormatterHelperProtocol) -> [InfoViewModel] {
        self.sorted { first, second in
            guard let firstDate = dateFormatter.parseDate(from: first.date),
                  let secondDate = dateFormatter.parseDate(from: second.date) else {
                return false
            }

            return firstDate > secondDate
        }
    }
}
