//
//  PhoneMask.swift
//  AuthAndMessages
//
//  Created by Mangust on 16.05.2025.
//

import Foundation

struct PhoneMaskFormatter {
    private let maxDigits = 10
    private var pattern = ""
    private(set) var digits: String = ""

    init(pattern: String) {
        self.pattern = pattern
    }

    mutating func input(character: String) {
        if character.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil {
            return
        }

        if digits.count < maxDigits {
            digits.append(character)
        }
    }

    mutating func deleteLast() {
        if !digits.isEmpty {
            digits.removeLast()
        }
    }

    func formattedNumber() -> String {
        var result = ""
        var index = digits.startIndex

        for ch in pattern {
            if ch == "X" {
                if index != digits.endIndex {
                    result.append(digits[index])
                    index = digits.index(after: index)
                } else {
                    break
                }
            } else {
                result.append(ch)
            }
        }
        return result
    }
}
