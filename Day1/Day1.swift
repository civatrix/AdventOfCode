//
//  Day1.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day1: Day {
    func run(input: String) -> String {
        let lines = input.split(separator: "\n", omittingEmptySubsequences: false)
        
        var calories = [0]
        
        for line in lines {
            if line.isEmpty {
                calories.append(0)
                continue
            }
            
            calories[calories.endIndex - 1] += Int(line)!
        }
        
        return "\(calories.sorted().suffix(3).reduce(0, +))"
    }
}
