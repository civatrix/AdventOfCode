//
//  Day16.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation
import RegexBuilder

final class Day16: Day {
    struct Valve {
        internal init(id: String, rate: Int, accessible: [String]) {
            self.id = id
            self.rate = rate
            self.accessible = accessible
        }
        
        let id: String
        let rate: Int
        var accessible: [String]
    }
    
    var valveMap = [String: Valve]()
    var distances = [String: [String: Int]]()
    func run(input: String) -> String {
        let regex = /Valve (.*) has flow rate=(\d*); tunnel[s]? lead[s]? to valve[s]? (.*)/
        
        input.lines.forEach { line in
            let match = try! regex.wholeMatch(in: line)!
            let valve = Valve(id: String(match.1), rate: Int(match.2)!, accessible: match.3.split(separator: ", ").map { String($0) })
            valveMap[valve.id] = valve
            for adjacent in valve.accessible {
                distances[valve.id, default: [:]][adjacent] = 1
                distances[adjacent, default: [:]][valve.id] = 1
            }
        }
        
        while valveMap.values.filter({ $0.rate == 0 && $0.accessible.count == 2 }).count > 0 {
            let valve = valveMap.values.first { $0.rate == 0 && $0.accessible.count == 2 }!
            valveMap[valve.accessible[0]]!.accessible.replace([valve.id], with: [valve.accessible[1]])
            valveMap[valve.accessible[1]]!.accessible.replace([valve.id], with: [valve.accessible[0]])
            
            distances[valve.accessible[0]]![valve.accessible[1]] = distances[valve.accessible[0]]![valve.id]! + distances[valve.id]![valve.accessible[1]]!
            distances[valve.accessible[1]]![valve.accessible[0]] = distances[valve.accessible[1]]![valve.id]! + distances[valve.id]![valve.accessible[0]]!
            valveMap.removeValue(forKey: valve.id)
        }
        
        let answer = recur(argument: .init(current: "AA", open: [], timeLeft: 30))
        return answer.description
    }
    
    struct Arguments: Hashable {
        let current: String
        let open: Set<String>
        let timeLeft: Int
    }
    
    var best = [Arguments: Int]()
    var rateCache = [Set<String>: Int]()
    func recur(argument: Arguments) -> Int {
        if argument.timeLeft <= 0 {
            best[argument] = 0
            return 0
        }
        if let answer = best[argument] { return answer }
        
        let flowRate: Int
        if let rate = rateCache[argument.open] {
            flowRate = rate
        } else {
            let rate = argument.open.map { valveMap[$0]!.rate }.sum
            rateCache[argument.open] = rate
            flowRate = rate
        }
        
        let current = valveMap[argument.current]!
        var possibleBest = flowRate * argument.timeLeft
        if !argument.open.contains(current.id) && current.rate > 0{
            possibleBest = recur(argument: .init(current: argument.current, open: argument.open.union([argument.current]), timeLeft: argument.timeLeft - 1)) + flowRate
        }
        
        for next in current.accessible {
            let distance = distances[current.id]![next]!
            if distance > argument.timeLeft { continue }
            let result = recur(argument: .init(current: next, open: argument.open, timeLeft: argument.timeLeft - distance)) + (distance * flowRate)
            possibleBest = max(possibleBest, result)
        }
        
        best[argument] = possibleBest
        return possibleBest
    }
}
