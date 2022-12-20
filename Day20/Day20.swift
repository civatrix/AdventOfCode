//
//  Day20.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day20: Day {
    func run(input: String) -> String {
        var array: [(Int, Int)] = input.allDigits.enumerated().map { $0 }
        let arraySize = array.count
        
        var move = 0
        while move < array.count {
            let oldIndex = array.firstIndex { $0.0 == move }!
            let value = array.remove(at: oldIndex)
            var newIndex = (oldIndex + value.1) % (arraySize - 1)
            while newIndex < 0 {
                newIndex += arraySize - 1
            }
        
            array.insert(value, at: newIndex)
            move += 1
        }
        
        let firstZeroIndex = array.firstIndex { $0.1 == 0 }!
        return [1000, 2000, 3000].map { array[wrapped: $0 + firstZeroIndex].1 }.sum.description
    }
}
