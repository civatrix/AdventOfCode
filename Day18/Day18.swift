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
    
    func run(input: String) -> String {
        let allPoints = Set(input.lines
            .map { $0.allDigits }
            .map { Point3D(x: $0[0], y: $0[1], z: $0[2]) })
        
        return allPoints.map { point in point.neighbours.filter { !allPoints.contains($0) }.count }.sum.description
    }
}
