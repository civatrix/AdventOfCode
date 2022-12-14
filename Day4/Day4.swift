//
//  Day4.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day4: Day {
    func run(input: String) -> String {
        return input.lines
            .filter { line in
                let ranges = line.split(separator: ",")
                let low1 = Int(ranges[0].split(separator: "-")[0])!
                let high1 = Int(ranges[0].split(separator: "-")[1])!
                let low2 = Int(ranges[1].split(separator: "-")[0])!
                let high2 = Int(ranges[1].split(separator: "-")[1])!
                
                return (low1...high1).overlaps(low2...high2)
            }
            .count
            .description
    }
}
