//
//  Day9.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day9: Day {
    func run(input: String) -> String {
        var head = Point.zero
        var tail = Point.zero
        var visited = Set<Point>([.zero])
        
        let directions: [Substring: Point] = ["D": .down, "U": .up, "L": .left, "R": .right]
        
        for line in input.lines {
            let directionString = line.split(separator: " ")[0]
            let count = Int(line.split(separator: " ")[1])!
            
            let direction = directions[directionString]!
            for _ in 1 ... count {
                let newHead = head + direction
                let vector = newHead - tail
                let distance2 = (vector.x * vector.x) + (vector.y * vector.y)
                if distance2 >= 4 {
                    tail = head
                    visited.insert(tail)
                }
                head = newHead
            }
        }
        
        visited.printPoints()
        
        return visited.count.description
    }
}
