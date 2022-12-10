//
//  ElfCode.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-12-10.
//

import Foundation

class ElfCode {
    enum Instruction {
        case noop, addx(Int), delay
        
        init(_ input: String) {
            let instruction = input.split(separator: " ")[0]
            switch instruction {
            case "noop": self = .noop
            case "addx": self = .addx(Int(input.split(separator: " ")[1])!)
            default:
                print("Unknown instruction: \(input)")
                exit(1)
            }
        }
    }
    
    var cycle = 1
    var register = 1
    var instructions: [Instruction]
    var instructionPointer = 0
    
    init(_ lines: [String]) {
        instructions = lines.map(Instruction.init)
        instructions = instructions.flatMap {
            switch $0 {
            case .delay, .noop:
                return [$0]
            case .addx(_):
                return [.delay, $0]
            }
        }
    }
    
    func step() -> Bool {
        let instruction = instructions[instructionPointer]
        switch instruction {
        case .noop, .delay:
            break
        case let .addx(value):
            register += value
        }
        
        instructionPointer += 1
        cycle += 1
        return instructionPointer < instructions.count
    }
}
