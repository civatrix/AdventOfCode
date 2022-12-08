//
//  Day8.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day8: Day {
    func run(input: String) -> String {
        let grid = input.lines.map { line in line.map { $0.wholeNumberValue! } }
        let transposedGrid = grid[0].indices.map { index in grid.map { $0[index] } }

        var maxScore = 0
        for (y, row) in grid.enumerated() {
            for (x, tree) in row.enumerated() {
                guard (x != 0) && (y != 0) else { continue }
                
                let left = row.prefix(upTo: x)
                let leftSeen = left.suffix { $0 < tree }
                
                let right = row.suffix(from: x + 1)
                let rightSeen = right.prefix { $0 < tree }
                
                let top = transposedGrid[x].prefix(upTo: y)
                let topSeen = top.suffix { $0 < tree }
                
                let bottom = transposedGrid[x].suffix(from: y + 1)
                let bottomSeen = bottom.prefix { $0 < tree }
                
                let leftScore = leftSeen.count + (left.count == leftSeen.count ? 0 : 1)
                let rightScore = rightSeen.count + (right.count == rightSeen.count ? 0 : 1)
                let topScore = topSeen.count + (top.count == topSeen.count ? 0 : 1)
                let bottomScore = bottomSeen.count + (bottom.count == bottomSeen.count ? 0 : 1)
                
                let score = leftScore * rightScore * topScore * bottomScore
                maxScore = max(score, maxScore)
            }
        }
        
        return maxScore.description
    }
}
