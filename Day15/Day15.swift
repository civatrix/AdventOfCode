//
//  Day15.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day15: Day {
    struct Pair {
        let sensor: Point
        let beacon: Point
        
        init(_ array: [Int]) {
            sensor = Point(x: array[0], y: array[1])
            beacon = Point(x: array[2], y: array[3])
        }
        
        func coveredArea(row: Int) -> Set<Point> {
            let distance = sensor.distance(to: beacon)
            
            guard (sensor.y - distance ... sensor.y + distance).contains(row) else { return [] }
            
            let distanceToRow = abs(row - sensor.y)
            let rowWidth = distance - distanceToRow

            return Set<Point>((sensor.x - rowWidth ... sensor.x + rowWidth).map { Point(x: $0, y: row) })
        }
    }
    
    func run(input: String) -> String {
        let pairs = input.lines.map { Pair($0.allDigits) }
        
        let targetRow = input.allDigits.max()! > 30 ? 2_000_000 : 10
        let coverage = pairs.reduce(Set<Point>()) { $0.union($1.coveredArea(row: targetRow)) }
        return coverage.subtracting(pairs.flatMap { [$0.beacon, $0.sensor] }).count.description
    }
}
