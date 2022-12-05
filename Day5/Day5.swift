//
//  Day5.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day5: Day {
    func run(input: String) -> String {
        let crates = input.allLines.split(separator: "")[0]
        let stackCount = crates.last!.allDigits.last!
        var stacks = [[Character]](repeating: [], count: stackCount)
        for line in crates {
            for (index, char) in line.enumerated() {
                guard char.isLetter else { continue }
                stacks[(index - 1) / 4].insert(char, at: 0)
            }
        }
        
        // Remove the stack identifiers
        let instructions = input.allDigits.dropFirst(stackCount)
        for instruction in instructions.chunks(ofCount: 3) {
            let count = instruction[instruction.startIndex]
            let start = instruction[instruction.startIndex.advanced(by: 1)] - 1
            let end = instruction[instruction.startIndex.advanced(by: 2)] - 1
            stacks[end].append(contentsOf: stacks[start].suffix(count))
            stacks[start] = stacks[start].dropLast(count)
        }
        
        return String(stacks.map { $0.last! })
    }
}
