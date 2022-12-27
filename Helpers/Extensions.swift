//
//  Extensions.swift
//  Advent of Code
//
//  Created by DanielJohns on 2022-01-07.
//

import Foundation

extension StringProtocol {
    var lines: [String] {
        split(separator: "\n").lazy.map { String($0) }
    }
    
    var allDigits: [Int] {
        let characterSet = CharacterSet(charactersIn: "-0123456789")
        return components(separatedBy: characterSet.inverted).filter { !$0.isEmpty }.map { Int($0)! }
    }
}

extension Array {
    subscript(wrapped wrapped: Int) -> Element {
        self[wrapped % count]
    }
    
    subscript(safe index: Int) -> Element? {
        guard index < endIndex && index >= startIndex else { return nil }
        return self[index]
    }
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        min(max(self, limits.lowerBound), limits.upperBound)
    }
}
