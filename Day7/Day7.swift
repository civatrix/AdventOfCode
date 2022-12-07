//
//  Day7.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

class Directory {
    var children: [Substring: Directory]
    var parent: Directory!
    var fileSizes: [Int] = []
    
    init(children: [Substring : Directory] = [:], parent: Directory! = nil) {
        self.children = children
        self.parent = parent
    }
    
    var totalSizes: [Int] {
        let childSizes = children.values.flatMap { $0.totalSizes }
        return childSizes + [fileSizes.sum + childSizes.sum]
    }
}

final class Day7: Day {
    func run(input: String) -> String {
        let root = Directory()
        var current = root
        
        for line in input.lines {
            if line.hasPrefix("$") {
                guard line.hasPrefix("$ cd") else { continue }
                
                let target = line.split(separator: " ").last!
                switch target {
                case "..": current = current.parent
                case "/": current = root
                default: current = current.children[target]!
                }
            } else if line.hasPrefix("dir") {
                current.children[line.split(separator: " ").last!] = Directory(parent: current)
            } else {
                current.fileSizes.append(Int(line.split(separator: " ").first!)!)
            }
        }
        
        return root.totalSizes.filter { $0 <= 100000 }.sum.description
    }
}
