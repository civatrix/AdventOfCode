//
//  Day1.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day1: Day {
    func run(input: String) -> String {
        return input.allLines
            .split(separator: "")
            .map { o in o.map { Int($0)! }.sum }
            .sorted()
            .suffix(3)
            .sum
            .description
    }
}
