//
//  Day17.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day17: Day {
    func run(input: String) -> String {
        let jets = input.dropLast().map { $0 == "<" ? Point.left : Point.right }
        let shapes: [[Point]] = [
            // Horizontal Line
            [[0,0],[1,0],[2,0],[3,0]],
            
            // Plus
            [[0,1],[1,0],[1,1],[2,1],[1,2]],
            
            // Backwards L
            [[0,2],[1,2],[2,0],[2,1],[2,2]],
            
            // Vertical Line
            [[0,0],[0,1],[0,2],[0,3]],
            
            // Square
            [[0,0],[1,0],[0,1],[1,1]]
        ]
        let boardBoundary = 0 ..< 7
        
        var board = Set<Point>(boardBoundary.map { [$0, 0] })
        var highestPoint = 0
        var step = 0
        for rockNumber in 0 ..< 2022 {
            var rock = shapes[wrapped: rockNumber]
            rock += .right + .right
            rock += .up * (highestPoint + 4 + rock.last!.y)
            while true {
                let wind = jets[wrapped: step]
                step += 1
                rock += wind
                if rock.contains(where: { !boardBoundary.contains($0.x) || board.contains($0) }) {
                    rock -= wind
                }
                
                rock += .down
                if rock.contains(where: { board.contains($0) }) {
                    rock -= .down
                    board.formUnion(rock)
                    highestPoint = max(-rock.map { $0.y }.min()!, highestPoint)
                    break
                }
            }
        }
        
        return highestPoint.description
    }
}

extension [Point] {
    static func -=(_ lhs: inout [Point], _ rhs: Point) {
        lhs = lhs.map { $0 - rhs }
    }
    
    static func +=(_ lhs: inout [Point], _ rhs: Point) {
        lhs = lhs.map { $0 + rhs }
    }
}
