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
        
        process(initial: .init(current: "AA", open: [], timeLeft: 26))
        
        var valveIndexes = [String: Int]()
        for (index, valve) in valveMap.values.enumerated() {
            valveIndexes[valve.id] = index
        }
        
        var bestPerValveSet = [Int: Int]()
        best.forEach {
            let mask = $0.key.open.map { 1 << valveIndexes[$0]! }.sum
            bestPerValveSet[mask] = max(bestPerValveSet[mask, default: 0], $0.value)
        }
        
        let valveCount = valveMap.count
        var bestCombination = 0
        for option in 1 ... 1 << valveCount {
            let compliment = ((1 << valveCount) - 1) ^ option
            let complimentResult = bestPerValveSet[compliment, default: 0]
            var mask = option
            while mask > 0 {
                bestCombination = max(bestCombination, complimentResult + bestPerValveSet[mask, default: 0])
                mask = (mask - 1) & option
            }
        }
        return bestCombination.description
    }
    
    func allPossiblePermutations(_ set: Set<String>) -> Set<Set<String>> {
        var combinedSet = Set<Set<String>>()
        
        for length in (2 ..< set.count) {
            let new = Set(set.permutations(ofCount: length).map { Set($0) })
            combinedSet.formUnion(new)
        }
        
        return combinedSet
    }
    
    struct Arguments: Hashable {
        let current: String
        let open: Set<String>
        let timeLeft: Int
    }
    
    var best = [Arguments: Int]()
    var rateCache = [Set<String>: Int]()
    func process(initial: Arguments) {
        var queue = [(initial, 0)]
        
        func addToQueue(_ arg: Arguments, _ flow: Int) {
            if arg.timeLeft >= 0 && best[arg, default: -1] < flow {
                queue.append((arg, flow))
                best[arg] = flow
            }
        }
        
        while let (next, flow) = queue.popLast() {
            let current = valveMap[next.current]!
            if !next.open.contains(current.id) && current.rate > 0 {
                let newOpen = next.open.union([current.id])
                addToQueue(Arguments(current: next.current, open: newOpen, timeLeft: next.timeLeft - 1), flow + (current.rate * (next.timeLeft - 1)))
            }
            
            for adjacent in current.accessible {
                let distance = distances[current.id]![adjacent]!
                if distance > next.timeLeft { continue }

                addToQueue(Arguments(current: adjacent, open: next.open, timeLeft: next.timeLeft - distance), flow)
            }
        }
    }
}
