//
//  Day9.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day9: Day {
    func run(input: String) -> String {
        var knots = Array<Point>(repeating: .zero, count: 10)
        var visited = Set<Point>([.zero])
        
        let directions: [Substring: Point] = ["D": .down, "U": .up, "L": .left, "R": .right]
        
        for line in input.lines {
            let directionString = line.split(separator: " ")[0]
            let count = Int(line.split(separator: " ")[1])!
            
            let direction = directions[directionString]!
            for _ in 1 ... count {
                knots[0] += direction
                for index in knots.indices.dropFirst() {
                    let head = knots[index - 1]
                    let tail = knots[index]
                    
                    let vector = head - tail
                    let distance2 = (vector.x * vector.x) + (vector.y * vector.y)
                    if distance2 >= 4 {
                        knots[index] += vector.normalized
                    }
                }
                visited.insert(knots.last!)
            }
        }
        
        return visited.count.description
    }
}
