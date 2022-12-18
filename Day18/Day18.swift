//
//  Day18.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day18: Day {    
    func run(input: String) -> String {
        var allPoints = Set(input.lines
            .map { $0.allDigits }
            .map { Point3D(x: $0[0], y: $0[1], z: $0[2]) })
        
        let end: Point3D = [-1, -1, -1]
        let aStar = AStar(graph: Grid3DGraph(walls: allPoints), heuristic: Point3D.distance(between:and:))
        allPoints = allPoints.filter { !aStar.path(start: $0, target: end).isEmpty }
                
        return allPoints.map { point in
            point.adjacent
                .filter { !allPoints.contains($0) }
                .filter { !aStar.path(start: $0, target: end).isEmpty }
                .count
        }
        .sum
        .description
    }
}
