//
//  Day17.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day17: Day {
    struct CacheKey: Hashable {
        let rockIndex, windIndex: Int
        let heights: [Int]
    }
    
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
        
        var cache = [CacheKey: (rock: Int, height: Int)]()
        var board = Set<Point>(boardBoundary.map { [$0, 0] })
        var highestPoint = 0
        var step = 0
        var rockNumber = 0
        var repeatHeight = 0
        while rockNumber < 1000000000000 {
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
            
            let heights = boardBoundary.map { x in highestPoint + board.filter { $0.x == x }.map { $0.y }.min()! }
            let cacheKey = CacheKey(rockIndex: rockNumber % shapes.count, windIndex: step % jets.count, heights: heights)
            if let (oldIndex, oldHeight) = cache[cacheKey] {
                let rockDelta = rockNumber - oldIndex
                let heightDelta = highestPoint - oldHeight
                let repeats = (1000000000000 - rockNumber) / rockDelta
                rockNumber += rockDelta * repeats
                repeatHeight = heightDelta * repeats
                cache = [:]
            } else {
                cache[cacheKey] = (rock: rockNumber, height: highestPoint)
            }
            
            rockNumber += 1
        }
        
        return (highestPoint + repeatHeight).description
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
