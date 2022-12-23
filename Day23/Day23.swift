//
//  Day23.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day23: Day {
    func run(input: String) -> String {
        var elves = [Point]()
        var elfSet = Set<Point>()
        var nextElves = [Point: [Int]]()
        var directionToSearch: [Point] = [.up, .down, .left, .right]
        
        for (row, line) in input.lines.enumerated() {
            for (column, char) in line.enumerated() {
                guard char == "#" else { continue }
                elves.append(.init(x: column, y: row))
            }
        }
        elfSet = Set(elves)
        
        var round = 1
        while true {
            for (index, elf) in elves.enumerated() {
                if elf.neighbours.allSatisfy({ !elfSet.contains($0) }) {
                    nextElves[elf, default: []].append(index)
                    continue
                }
                
                for search in directionToSearch {
                    let corner = Point(x: search.y, y: search.x)
                    if [elf + search + corner, elf + search, elf + search - corner].allSatisfy({ !elfSet.contains($0) }) {
                        nextElves[elf + search, default: []].append(index)
                        break
                    }
                }
            }
                        
            nextElves.filter { $0.value.count == 1 }
                .forEach {
                    elves[$0.value[0]] = $0.key
                }
            let newElfSet = Set(elves)
            if elfSet == newElfSet {
                return round.description
            }
            elfSet = newElfSet
            nextElves = [:]
            directionToSearch.rotate(toStartAt: 1)
            round += 1
        }
    }
}
