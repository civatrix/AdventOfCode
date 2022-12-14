//
//  Day14.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day14: Day {
    func run(input: String) -> String {
        var cave = Set<Point>()
        for line in input.lines.map({ $0.allDigits }) {
            for (p1, p2) in line.chunks(ofCount: 2).map({ Point(x: $0[$0.startIndex], y: $0[$0.startIndex.advanced(by: 1)]) }).adjacentPairs() {
                if p1.x == p2.x {
                    let minY = min(p1.y, p2.y)
                    let maxY = max(p1.y, p2.y)
                    cave.formUnion((minY ... maxY).map { Point(x: p1.x, y: $0) })
                } else if p1.y == p2.y {
                    let minX = min(p1.x, p2.x)
                    let maxX = max(p1.x, p2.x)
                    cave.formUnion((minX ... maxX).map { Point(x: $0, y: p1.y) })
                } else {
                    print("Invalid point combination: \(p1), \(p2)")
                }
            }
        }
        let initialCaveCount = cave.count
        let bottom = cave.map { $0.y }.max()!
        
        var sand = Point(x: 500, y: 0)
        while true {
            if !cave.contains(sand + .down) {
                sand += .down
            } else if !cave.contains(sand + .down + .left) {
                sand += .down + .left
            } else if !cave.contains(sand + .down + .right) {
                sand += .down + .right
            } else {
                cave.insert(sand)
                sand = Point(x: 500, y: 0)
            }
            
            if sand.y > bottom {
                break
            }
        }
        
        return (cave.count - initialCaveCount).description
    }
}
