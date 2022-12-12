//
//  Day12.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day12: Day {
    struct TopGraph: Graph {
        let grid: [[Int]]
        
        struct Edge: WeightedEdge {
            let target: Point
            let cost = 1
        }
        
        func edgesOutgoing(from vertex: Point) -> [Edge] {
            return vertex.adjacent.filter {
                ($0.value(in: grid) ?? .max) <= vertex.value(in: grid)! + 1
            }.map(Edge.init)
        }
    }
    
    func run(input: String) -> String {
        var start: Point!
        var end: Point!
        
        let map = input.lines.enumerated().map { (y, line) in
            line.enumerated().map { (x, char) in
                if char == "S" {
                    start = Point(x: x, y: y)
                    return 0
                } else if char == "E" {
                    end = Point(x: x, y: y)
                    return 25
                } else {
                    return Int(char.asciiValue! - Character("a").asciiValue!)
                }
            }
        }
        
        let graph = TopGraph(grid: map)
        let aStar = AStar(graph: graph, heuristic: Point.distance(between:and:))
        let path = aStar.path(start: start, target: end)
        
        return (path.count - 1).description
    }
}
