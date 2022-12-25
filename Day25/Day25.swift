//
//  Day25.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day25: Day {
    func run(input: String) -> String {
        return input.lines.map {
            $0.reversed().enumerated().map { (index, character) in
                let base: Int
                switch character {
                case "1": base = 1
                case "2": base = 2
                case "-": base = -1
                case "=": base = -2
                case "0": base = 0
                default: exit(2)
                }
                
                return 5.power(to: index) * base
            }.sum
        }
        .sum
        .snafu
    }
}

extension Int {
    func power(to: Int) -> Int {
        [Int](repeating: self, count: to).reduce(1, *)
    }
    
    var snafu: String {
        var result = [Int: [Int]]()
        var mutable = self
        var index = 0
        while mutable >= 1 {
            let remainder = mutable % 5
            mutable /= 5
            
            switch remainder {
            case 0: result[index, default: []].append(0)
            case 1: result[index, default: []].append(1)
            case 2: result[index, default: []].append(2)
            case 3:
                result[index, default: []].append(-2)
                result[index + 1, default: []].append(1)
            case 4:
                result[index, default: []].append(-1)
                result[index + 1, default: []].append(1)
            default: exit(3)
            }
            
            index += 1
            while result.values.contains(where: { $0.sum == 3 }) {
                let key = result.keys.sorted().first { result[$0]!.sum == 3 }!
                result[key] = [-2]
                result[key + 1, default: []].append(1)
            }
        }
        
        return result.sorted { $0.key < $1.key }.map { $0.value.sum }.reversed().map { number in
            switch number {
            case -2: return "="
            case -1: return "-"
            case 0: return "0"
            case 1: return "1"
            case 2: return "2"
            default: exit(4)
            }
        }.joined()
    }
}
