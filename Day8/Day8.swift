//
//  Day8.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day8: Day {
    func run(input: String) -> String {
        var visibleTrees = Set<Point>()
        
        let lines = input.lines
        let maxX = lines[0].count - 1
        let maxY = lines.count - 1
        
        for x in 0 ... maxX {
            visibleTrees.insert(Point(x: x, y: 0))
            visibleTrees.insert(Point(x: x, y: maxY))
        }
        
        for y in 0 ... maxY {
            visibleTrees.insert(Point(x: 0, y: y))
            visibleTrees.insert(Point(x: maxX, y: y))
        }
        
        let grid = lines.map { line in line.map { $0.wholeNumberValue! } }
        for (y, row) in grid.enumerated() {
            for (x, tree) in row.enumerated() {
                let point = Point(x: x, y: y)
                guard !visibleTrees.contains(point) else { continue }
                
                let left = row.prefix(upTo: x)
                if left.max() ?? 0 < tree {
                    visibleTrees.insert(point)
                    continue
                }
                let right = row.suffix(from: x + 1)
                if right.max() ?? 0 < tree {
                    visibleTrees.insert(point)
                    continue
                }
            }
        }
        
        let transposedGrid = grid[0].indices.map { index in grid.map { $0[index] } }
        for (y, row) in transposedGrid.enumerated() {
            for (x, tree) in row.enumerated() {
                let point = Point(x: y, y: x)
                guard !visibleTrees.contains(point) else { continue }
                
                let left = row.prefix(upTo: x)
                if left.max() ?? 0 < tree {
                    visibleTrees.insert(point)
                    continue
                }
                let right = row.suffix(from: x + 1)
                if right.max() ?? 0 < tree {
                    visibleTrees.insert(point)
                    continue
                }
            }
        }
        
        return visibleTrees.count.description
    }
}
