//
//  Day10.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day10: Day {
    func run(input: String) -> String {
        let targetCycles = Set([20, 60, 100, 140, 180, 220])
        
        var register = 1
        var cycle = 1
        var signal = 0
        for line in input.lines {
            if targetCycles.contains(cycle) {
                signal += cycle * register
            }
            if line.hasPrefix("noop") {
                cycle += 1
            } else {
                if targetCycles.contains(cycle + 1) {
                    signal += (cycle + 1) * register
                }
                let value = Int(line.split(separator: " ")[1])!
                register += value
                cycle += 2
            }
        }
        
        return signal.description
    }
}
