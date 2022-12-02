//
//  Day2.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day2: Day {
    enum Play: Character, Comparable {
        case rock = "A"
        case paper = "B"
        case scissors = "C"
        
        static let order: [Play] = [.rock, .paper, .scissors, .rock]
        
        var throwScore: Int {
            switch self {
            case .rock: return 1
            case .paper: return 2
            case .scissors: return 3
            }
        }
        
        func playToAchieve(result: Character) -> Play {
            switch result {
            case "X": return Play.order[Play.order.lastIndex(of: self)! - 1]
            case "Y": return self
            case "Z": return Play.order[Play.order.firstIndex(of: self)! + 1]
            default: exit(2)
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
            let opponent = Play(rawValue: line.first!)!
            let you = opponent.playToAchieve(result: line.last!)
            
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
