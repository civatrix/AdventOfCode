//
//  Day6.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day6: Day {
    func run(input: String) -> String {
        var buffer = [Character]()
        let index = input.firstIndex { char in
            if buffer.count == 4 {
                buffer = Array(buffer.dropFirst())
            }
            buffer.append(char)
            
            return Set(buffer).count == 4
        }!
        
        return (input.distance(from: input.startIndex, to: index) + 1).description
    }
}
