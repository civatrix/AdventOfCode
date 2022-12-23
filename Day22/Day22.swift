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
    
    struct WarpKey: Hashable, CustomStringConvertible {
        let point, direction: Point
        
        var description: String {
            let facingValue: String
            switch direction {
            case .right: facingValue = "right"
            case .down: facingValue = "down"
            case .left: facingValue = "left"
            case .up: facingValue = "up"
            default:
                print("Invalid facing direction \(direction)")
                exit(1)
            }
            return "([\(point.x), \(point.y)], \(facingValue))"
        }
    }
    
    var map = [Point: State]()
    func run(input: String) -> String {
        var lines = input.lines
        var route = lines.popLast()!
        
        for (row, line) in lines.enumerated() {
            for (column, cell) in line.enumerated() {
                if let state = State(rawValue: cell) {
                    map[Point(x: column, y: row)] = state
                }
            }
        }
        
        
        var warps = [WarpKey: WarpKey]()
        for point in map.keys {
            for direction1 in [Point.up, Point.down] {
                for direction2 in [Point.left, Point.right] {
                    if map[(point + direction1 + direction2)] == nil && map[(point + direction1)] != nil && map[(point + direction2)] != nil {
                        warps.merge(walkCorner(start: point, direction1: direction1, direction2: direction2)) { _, _ in exit(2) }
                    }
                }
            }
        }
        
        let regex = Regex {
            TryCapture { OneOrMore(.digit) } transform: { Int($0) }
            Capture { ZeroOrMore(.anyOf("RL")) }
        }
        
        var position = map.keys.min()!
        var facing = Point.right
        while !route.isEmpty {
            let instruction = route.prefixMatch(of: regex)!
            route.removeSubrange(instruction.range)
            
            let count = instruction.output.1
            let direction = instruction.output.2
            
            for _ in 0 ..< count {
                var newPosition = position + facing
                var newLocation = map[newPosition]
                if newLocation == .wall {
                    break
                } else if newLocation == .open {
                    position = newPosition
                } else {
                    let newKey = warps[.init(point: position, direction: facing)]!
                    newPosition = newKey.point
                    newLocation = map[newPosition]
                    if newLocation == .wall {
                        break
                    } else if newLocation == .open {
                        position = newPosition
                        facing = newKey.direction
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
    
    func walkCorner(start: Point, direction1: Point, direction2: Point) -> [WarpKey: WarpKey] {
        var warps = [WarpKey: WarpKey]()
        
        var walk1 = start
        var walk1Direction = direction1
        var preWarpDirection1 = direction2
        var warpDirection1 = preWarpDirection1 * -1
        
        var walk2 = start
        var walk2Direction = direction2
        var preWarpDirection2 = direction1
        var warpDirection2 = preWarpDirection2 * -1
        
        
        while true {
            walk1 += walk1Direction
            walk2 += walk2Direction
            guard map[walk1] != nil || map[walk2] != nil else { break }
            
            if map[walk1] == nil {
                walk1 -= walk1Direction
                let newDirection = walk1Direction.rotate(clockwise: true)
                if map[walk1 + newDirection] != nil {
                    preWarpDirection1 = walk1Direction
                    warpDirection1 = preWarpDirection1 * -1
                    walk1Direction = newDirection
                } else {
                    let newDirection = walk1Direction.rotate(clockwise: false)
                    if map[walk1 + newDirection] != nil {
                        preWarpDirection1 = walk1Direction
                        warpDirection1 = preWarpDirection1 * -1
                        walk1Direction = newDirection
                    } else {
                        assertionFailure("Something broke")
                    }
                }
            }
            
            if map[walk2] == nil {
                walk2 -= walk2Direction
                let newDirection = walk2Direction.rotate(clockwise: true)
                if map[walk2 + newDirection] != nil {
                    preWarpDirection2 = walk2Direction
                    warpDirection2 = preWarpDirection2 * -1
                    walk2Direction = newDirection
                } else {
                    let newDirection = walk2Direction.rotate(clockwise: false)
                    if map[walk2 + newDirection] != nil {
                        preWarpDirection2 = walk2Direction
                        warpDirection2 = preWarpDirection2	 * -1
                        walk2Direction = newDirection
                    } else {
                        assertionFailure("Something broke")
                    }
                }
            }
            
            warps[.init(point: walk1, direction: preWarpDirection1)] = .init(point: walk2, direction: warpDirection2)
            warps[.init(point: walk2, direction: preWarpDirection2)] = .init(point: walk1, direction: warpDirection1)
        }
        
        return warps
    }
}
