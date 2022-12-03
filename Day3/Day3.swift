//
//  Day3.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day3: Day {
    func run(input: String) -> String {
        return input.lines.map { line in
            let firstHalf = line.prefix(line.count / 2)
            let lastHalf = line.suffix(line.count / 2)
            let shared = Set(firstHalf).intersection(Set(lastHalf)).first!
            
            if shared <= "Z" {
                return Int(shared.asciiValue! - Character("A").asciiValue!) + 27
            } else {
                return Int(shared.asciiValue! - Character("a").asciiValue!) + 1
            }
        }
        .sum
        .description
    }
}
