//
//  Day18.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day18: Day {
    struct Point3D: Hashable, ExpressibleByArrayLiteral {
        let x, y, z: Int
        
        static let left: Point3D = [-1, 0, 0]
        static let right: Point3D = [1, 0, 0]
        static let up: Point3D = [0, -1, 0]
        static let down: Point3D = [0, 1, 0]
        static let towards: Point3D = [0, 0, -1]
        static let away: Point3D = [0, 0, 1]
        
        static func +(_ lhs: Point3D, rhs: Point3D) -> Point3D {
            [lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z]
        }
        
        static func distance(between to: Point3D, and from: Point3D) -> Int {
            abs(to.x - from.x) + abs(to.y + from.y) + abs(to.z + from.z)
        }
        
        init(x: Int, y: Int, z: Int) {
            self.x = x
            self.y = y
            self.z = z
        }
        
        init(arrayLiteral elements: Int...) {
            self = Point3D(x: elements[0], y: elements[1], z: elements[2])
        }
        
        var neighbours: [Point3D] {
            [.left, .right, .up, .down, .towards, .away].map { $0 + self }
        }
    }
    
    struct Grid3DGraph: Graph {
        struct Edge: WeightedEdge {
            let cost = 1
            let target: Point3D
        }
        
        let walls: Set<Point3D>
        
        func edgesOutgoing(from vertex: Point3D) -> [Edge] {
            return vertex.neighbours.filter { !walls.contains($0) }
                .map { Edge(target: $0) }
        }
    }
    
    func run(input: String) -> String {
        var allPoints = Set(input.lines
            .map { $0.allDigits }
            .map { Point3D(x: $0[0], y: $0[1], z: $0[2]) })
        
        let end: Point3D = [-1, -1, -1]
        let aStar = AStar(graph: Grid3DGraph(walls: allPoints), heuristic: Point3D.distance(between:and:))
        allPoints = allPoints.filter { !aStar.path(start: $0, target: end).isEmpty }
                
        return allPoints.map { point in
            point.neighbours
                .filter { !allPoints.contains($0) }
                .filter { !aStar.path(start: $0, target: end).isEmpty }
                .count
        }
        .sum
        .description
    }
}
