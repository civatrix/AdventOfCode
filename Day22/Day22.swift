//
//  Day22.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation
import RegexBuilder

final class Day22: Day {
    enum State: Character {
        case open = ".", wall = "#"
    }
    
    func run(input: String) -> String {
        var map = [Point: State]()
        var lines = input.lines
        var route = lines.popLast()!
        
        for (row, line) in lines.enumerated() {
            for (column, cell) in line.enumerated() {
                if let state = State(rawValue: cell) {
                    map[Point(x: column, y: row)] = state
                }
            }
        }
        
        let regex = Regex {
            Capture { OneOrMore(.digit) }
            Capture { ZeroOrMore(.anyOf("RL")) }
        }
        
        var position = map.keys.min()!
        var facing = Point.right
        while !route.isEmpty {
            let instruction = route.prefixMatch(of: regex)!
            route.removeSubrange(instruction.range)
            
            let count = Int(instruction.output.1)!
            let direction = instruction.output.2
            
            for _ in 0 ..< count {
                var newPosition = position + facing
                var newLocation = map[newPosition]
                if newLocation == .wall {
                    break
                } else if newLocation == .open {
                    position = newPosition
                } else {
                    repeat {
                        newPosition -= facing
                    } while map[newPosition] != nil
                    
                    newPosition += facing
                    newLocation = map[newPosition]
                    if newLocation == .wall {
                        break
                    } else if newLocation == .open {
                        position = newPosition
                    } else {
                        assertionFailure()
                    }
                }
            }
            
            if direction != "" {
                facing = facing.rotate(clockwise: direction == "R")
            }
        }
        
        let facingValue: Int
        switch facing {
        case .right: facingValue = 0
        case .down: facingValue = 1
        case .left: facingValue = 2
        case .up: facingValue = 3
        default:
            print("Invalid facing direction \(facing)")
            exit(1)
        }
        return (((position.y + 1) * 1000) + ((position.x + 1) * 4) + facingValue).description
    }
}
