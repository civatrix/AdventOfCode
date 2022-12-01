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
        
        var current = 0
        var best = 0
        
        for line in lines {
            if line.isEmpty {
                best = max(current, best)
                current = 0
                continue
            }
            
            current += Int(line)!
        }
        
        return "\(best)"
    }
}
