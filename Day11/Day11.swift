//
//  Day11.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day11: Day {
    class Monkey {
        var items: [Int]
        let operation: (Int) -> Int
        let test: (Int) -> Bool
        let trueTarget: Int
        let falseTarget: Int
        var inspectCount = 0
        
        init(items: [Int], operation: @escaping (Int) -> Int, test: @escaping (Int) -> Bool, trueTarget: Int, falseTarget: Int) {
            self.items = items
            self.operation = operation
            self.test = test
            self.trueTarget = trueTarget
            self.falseTarget = falseTarget
        }
    }
    
    func run(input: String) -> String {
        let lines = input.lines
        
        var monkeys = [Monkey]()
        var index = 0
        while index < lines.endIndex {
            let items = lines[index + 1].allDigits
            
            let operation: (Int) -> Int
            let operationLine = lines[index + 2]
            let rhs = operationLine.allDigits.first
            if operationLine.contains("*") {
                operation = { $0 * (rhs ?? $0) }
            } else if operationLine.contains("+") {
                operation = { $0 + (rhs ?? $0) }
            } else {
                print("invalid operation \(operationLine)")
                exit(1)
            }
            
            let divisible = lines[index + 3].allDigits[0]
            let trueTarget = lines[index + 4].allDigits[0]
            let falseTarget = lines[index + 5].allDigits[0]
            
            monkeys.append(.init(items: items, operation: operation, test: { $0 % divisible == 0 }, trueTarget: trueTarget, falseTarget: falseTarget))
            
            index += 6
        }
        
        for _ in 1 ... 20 {
            for monkey in monkeys {
                monkey.inspectCount += monkey.items.count
                for item in monkey.items {
                    let newItem = monkey.operation(item) / 3
                    if monkey.test(newItem) {
                        monkeys[monkey.trueTarget].items.append(newItem)
                    } else {
                        monkeys[monkey.falseTarget].items.append(newItem)
                    }
                }
                monkey.items = []
            }
        }
        
        return monkeys.map { $0.inspectCount }.sorted().suffix(2).reduce(1, *).description
    }
}
