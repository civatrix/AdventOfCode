//
//  Day3.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation
import Algorithms

final class Day3: Day {
    func run(input: String) -> String {
        return input.lines
            .chunks(ofCount: 3)
            .map { chunk in
                let first = chunk[chunk.startIndex]
                let second = chunk[chunk.startIndex.advanced(by: 1)]
                let third = chunk[chunk.startIndex.advanced(by: 2)]
                let shared = Set(first).intersection(Set(second).intersection(Set(third))).first!
                
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
