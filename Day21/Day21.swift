//
//  Day21.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day21: Day {
    func run(input: String) -> String {
        var numbers = [String: Int]()
        var monkeys = [[String]]()
        
        input.replacing(":", with: "").lines.forEach {
            let components = $0.split(separator: " ").map(String.init)
            if components.count == 2 {
                numbers[components[0]] = Int(components[1])!
            } else {
                monkeys.append(components)
            }
        }
        numbers.removeValue(forKey: "humn")
        
        var monkeyCount = 0
        while monkeyCount != monkeys.count {
            monkeyCount = monkeys.count
            monkeys = monkeys.filter {
                if let lhs = numbers[$0[1]], let rhs = numbers[$0[3]] {
                    let value: Int
                    switch $0[2] {
                    case "+": value = lhs + rhs
                    case "-": value = lhs - rhs
                    case "*": value = lhs * rhs
                    case "/": value = lhs / rhs
                    default:
                        print("Unknown operator \($0)")
                        exit(1)
                    }
                    numbers[$0[0]] = value
                    
                    return false
                } else {
                    return true
                }
            }
        }
        
        let table = [String: [String]](uniqueKeysWithValues: monkeys.map {
            var new = $0
            if let lhs = numbers[$0[1]] {
                new[1] = "\(lhs)"
            } else if let rhs = numbers[$0[3]] {
                new[3] = "\(rhs)"
            }
            
            if new[0] == "root" {
                new[2] = "="
            }
            
            return (new[0], new.suffix(3))
        })
        
        var key = "root"
        var value = 0
        
        while key != "humn" {
            let entry = table[key]!
            if let lhs = Int(entry[0]) {
                switch entry[1] {
                case "+": value -= lhs
                case "-": value = lhs - value
                case "*": value /= lhs
                case "/": value = lhs / value
                case "=": value = lhs
                default:
                    print("Unknown operator \(entry)")
                    exit(1)
                }
                
                key = entry[2]
            } else if let rhs = Int(entry[2]) {
                switch entry[1] {
                case "+": value -= rhs
                case "-": value += rhs
                case "*": value /= rhs
                case "/": value *= rhs
                case "=": value = rhs
                default:
                    print("Unknown operator \(entry)")
                    exit(1)
                }
                
                key = entry[0]
            } else {
                print("No number found: \(key), \(entry)")
                exit(1)
            }
        }
        
        return value.description
    }
}
