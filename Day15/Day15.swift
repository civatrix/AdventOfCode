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
        
        let distance: Int
        let top: Point
        let yRange: ClosedRange<Int>
        
        init(_ array: [Int]) {
            sensor = Point(x: array[0], y: array[1])
            beacon = Point(x: array[2], y: array[3])
            
            distance = sensor.distance(to: beacon)
            top = sensor - Point(x: 0, y: distance)
            
            yRange = top.y ... sensor.y + distance
        }
        
        func contenders(maxSize: Int) -> Set<Point> {
            var set = Set<Point>()
            
            for (index, row) in (top.y - 1 ... sensor.y).enumerated() where row >= 0 && row <= maxSize {
                set.insert(Point(x: sensor.x + index, y: row))
                set.insert(Point(x: sensor.x - index, y: row))
                set.insert(Point(x: sensor.x + index, y: row + distance + distance - index - index))
                set.insert(Point(x: sensor.x - index, y: row + distance + distance - index - index))
            }
            
            return set.filter { $0.x >= 0 && $0.x <= maxSize }
        }
        
        func contains(_ point: Point) -> Bool {
            guard yRange.contains(point.y) else { return false }
            
            let distanceToRow = abs(point.y - sensor.y)
            let rowWidth = distance - distanceToRow
            
            return (sensor.x - rowWidth ... sensor.x + rowWidth).contains(point.x)
        }
    }
    
    func run(input: String) -> String {
        let pairs = input.lines.map { Pair($0.allDigits) }
        let maxSize = input.allDigits.max()! > 30 ? 4_000_000 : 20
                
        var contenders = Set<Point>()
        var doubles = Set<Point>()
        
        for pair in pairs {
            let new = pair.contenders(maxSize: maxSize)
            let newDoubles = contenders.intersection(new)
            contenders.formUnion(new)
            doubles.formUnion(newDoubles)
        }
        
        let signal = doubles.first { point in pairs.allSatisfy { !$0.contains(point) } }!
        return ((signal.x * 4_000_000) + signal.y).description
    }
}
