//
//  Day10.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day10: Day {
    func run(input: String) -> String {
        let cpu = ElfCode(input.lines)
        
        var output = ""
        repeat {
            if (cpu.register - 1 ... cpu.register + 1).contains((cpu.cycle - 1) % 40) {
                output += "#"
            } else {
                output += "."
            }
            
            if output.split(separator: "\n").last!.count % 40 == 0 {
                output += "\n"
            }
        } while cpu.step()
                
        return output
    }
}
