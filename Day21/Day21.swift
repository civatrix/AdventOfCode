//
//  Day21.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day21: Day {
    func run(input: String) -> String {
        var numbers = [Substring: Int]()
        var monkeys = [[Substring]]()
        
        input.replacing(":", with: "").lines.forEach {
            let components = $0.split(separator: " ")
            if components.count == 2 {
                numbers[components[0]] = Int(components[1])!
            } else {
                monkeys.append(components)
            }
        }
        
        while numbers["root"] == nil {
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
        
        return numbers["root"]!.description
    }
}
