//
//  Day10.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day10: Day {
    func run(input: String) -> String {
        var register = 1
        var cycle = 1
        var output = ""
        for line in input.lines {
            if (register - 1 ... register + 1).contains((cycle - 1) % 40) {
                output += "#"
            } else {
                output += "."
            }
            
            if output.split(separator: "\n").last!.count % 40 == 0 {
                output += "\n"
            }
            
            if line.hasPrefix("noop") {
                cycle += 1
            } else {
                if (register - 1 ... register + 1).contains(cycle % 40) {
                    output += "#"
                } else {
                    output += "."
                }
                
                if output.split(separator: "\n").last!.count % 40 == 0 {
                    output += "\n"
                }
                let value = Int(line.split(separator: " ")[1])!
                register += value
                cycle += 2
            }
        }
        
        return output
    }
}
