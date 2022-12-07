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
    
    var totalSize: Int {
        fileSizes.sum + children.values.map { $0.totalSize }.sum
    }
    
    var allSizes: [Int] {
        [totalSize] + children.values.flatMap { $0.allSizes }
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
        
        let target = 30000000 - (70000000 - root.totalSize)
        return root.allSizes.filter { $0 > target }.sorted().first!.description
    }
}
