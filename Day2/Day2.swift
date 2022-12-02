//
//  Day2.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day2: Day {
    func run(input: String) -> String {
        let map = [
            "A X": 3 + 0,
            "A Y": 1 + 3,
            "A Z": 2 + 6,
            "B X": 1 + 0,
            "B Y": 2 + 3,
            "B Z": 3 + 6,
            "C X": 2 + 0,
            "C Y": 3 + 3,
            "C Z": 1 + 6,
        ]
        
        return input.lines
            .map { map[$0]! }
            .sum
            .description
    }
}
