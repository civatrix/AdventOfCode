//
//  Day19.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day19: Day {
    let ore = 0
    let clay = 1
    let obsidian = 2
    let geode = 3
        
    struct CacheKey: Hashable {
        let resources: [Int]
        let robots: [Int]
        let timeLeft: Int
    }
    
    func run(input: String) -> String {
        return input.lines
            .map {
                let numbers = $0.allDigits
                
                return [
                    [numbers[1], 0, 0, 0],
                    [numbers[2], 0, 0, 0],
                    [numbers[3], numbers[4], 0, 0],
                    [numbers[5], 0, numbers[6], 0],
                ]
            }
            .map(run(blueprint:))
            .enumerated()
            .map { ($0.offset + 1) * $0.element }
            .sum
            .description
    }
    
    func run(blueprint: [[Int]]) -> Int {
        var bestCount = 0
        var queue = [CacheKey]()
        queue.append(CacheKey(resources: [0,0,0,0], robots: [1,0,0,0], timeLeft: 24))
        
        let maxCosts = (ore ... geode).map { key in blueprint.map { $0[key] }.max()! }
        
        func addToQueue(_ key: CacheKey) {
            guard key.timeLeft >= 0 else { return }
            let geodes = key.resources[geode]
            if geodes > bestCount {
                bestCount = geodes
                queue = queue.filter { key in
                    geodes + key.robots[geode] * key.timeLeft + (1 ... key.timeLeft).sum >= bestCount
                }
            }
            
            if key.timeLeft > 0 && geodes + key.robots[geode] * key.timeLeft + (1 ... key.timeLeft).sum >= bestCount {
                queue.append(key)
            }
        }
        
        while let key = queue.popLast() {
            let doNothingResources = zip(key.resources, key.robots).map { $0.0 + (key.timeLeft * $0.1) }
            addToQueue(.init(resources: doNothingResources, robots: key.robots, timeLeft: 0))
            
            for robot in (ore ... geode) {
                guard robot == geode || key.robots[robot] < maxCosts[robot] else { continue }
                guard zip(key.robots, blueprint[robot]).allSatisfy({ $1 == 0 || $0 != 0}) else { continue }
                
                var newResources = key.resources
                var timePassed = 0
                while !zip(newResources, blueprint[robot]).allSatisfy({ $0.0 >= $0.1 }) {
                    newResources = zip(newResources, key.robots).map { $0.0 + $0.1 }
                    timePassed += 1
                }
                
                newResources = zip(newResources, key.robots).map { $0.0 + $0.1 }
                timePassed += 1
                
                var newRobots = key.robots
                newRobots[robot] += 1
                addToQueue(.init(resources: zip(newResources, blueprint[robot]).map { $0.0 - $0.1 }, robots: newRobots, timeLeft: key.timeLeft - timePassed))
            }
        }
        
        return bestCount
    }
}
