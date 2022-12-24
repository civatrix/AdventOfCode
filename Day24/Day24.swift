//
//  Day24.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day24: Day {
    func run(input: String) -> String {
        let lines = input.lines
        let width = lines[0].count - 2
        let height = lines.count - 2
        let start = Point(x: lines[0].distance(from: lines[0].startIndex, to: lines[0].firstIndex(of: ".")!), y: 0)
        let end = Point(x: lines.last!.distance(from: lines.last!.startIndex, to: lines.last!.firstIndex(of: ".")!), y: lines.count - 1)
        
        var windStarts = [Point: Set<Point>]()
        var walls = Set<Point>([start + .up, end + .down])
        for (row, line) in input.lines.enumerated() {
            for (column, char) in line.enumerated() {
                let point = Point(x: column, y: row)
                switch char {
                case ">": windStarts[.right, default: []].insert(point)
                case "<": windStarts[.left, default: []].insert(point)
                case "^": windStarts[.up, default: []].insert(point)
                case "v": windStarts[.down, default: []].insert(point)
                case "#": walls.insert(point)
                default: break
                }
            }
        }
        
        var time = 0
        var positions = Set<Point>([start])
        while true {
            time += 1
            let winds = windPositions(at: time, starts: windStarts, width: width, height: height)
            
            let newPositions = positions.flatMap { move in
                ([move] + move.adjacent).filter {
                    !walls.contains($0) && !winds.contains($0)
                }
            }
            positions = Set(newPositions)
            if positions.contains(end) {
                return time.description
            }
        }
    }
    
    func windPositions(at: Int, starts: [Point: Set<Point>], width: Int, height: Int) -> Set<Point> {
        var winds = Set<Point>()
        
        starts[.left]?.forEach { wind in
            var newWind = wind + (Point.left * (at % width))
            if newWind.x <= 0 {
                newWind += Point.right * width
            }
            winds.insert(newWind)
        }
        starts[.right]?.forEach { wind in
            var newWind = wind + (Point.right * (at % width))
            if newWind.x >= width + 1 {
                newWind += Point.left * width
            }
            winds.insert(newWind)
        }
        starts[.up]?.forEach { wind in
            var newWind = wind + (Point.up * (at % height))
            if newWind.y <= 0 {
                newWind += Point.down * height
            }
            winds.insert(newWind)
        }
        starts[.down]?.forEach { wind in
            var newWind = wind + (Point.down * (at % height))
            if newWind.y >= height + 1 {
                newWind += Point.up * height
            }
            winds.insert(newWind)
        }
        
        return winds
    }
}
