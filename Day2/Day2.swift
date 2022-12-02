//
//  Day2.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day2: Day {
    enum Play: Comparable {
        case rock, paper, scissors
        
        init(_ char: Character) {
            switch char {
            case "A", "X": self = .rock
            case "B", "Y": self = .paper
            case "C", "Z": self = .scissors
            default: exit(2)
            }
        }
        
        var throwScore: Int {
            switch self {
            case .rock: return 1
            case .paper: return 2
            case .scissors: return 3
            }
        }
        
        static func < (lhs: Play, rhs: Play) -> Bool {
            return (lhs == .rock && rhs == .paper) ||
            (lhs == .paper && rhs == .scissors) ||
            (lhs == .scissors && rhs == .rock)
        }
    }
    
    func run(input: String) -> String {
        let lines = input.lines
                
        var score = 0
        for line in lines {
            let opponent = Play(line.first!)
            let you = Play(line.last!)
            
            score += you.throwScore
            
            if opponent == you {
                score += 3
            } else if opponent < you {
                score += 6
            }
        }
        
        return score.description
    }
}
