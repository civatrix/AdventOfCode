//
//  Day13.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day13: Day {
    enum Packet: Comparable, Decodable {
        static func < (lhs: Day13.Packet, rhs: Day13.Packet) -> Bool {
            switch (lhs, rhs) {
            case let (.int(lhsInt), .int(rhsInt)):
                return lhsInt < rhsInt
            case let (.list(lhsList), .list(rhsList)):
                for a in zip(lhsList, rhsList) {
                    if a.0 < a.1 {
                        return true
                    } else if a.1 < a.0 {
                        return false
                    } else {
                        continue
                    }
                }
                return lhsList.count <= rhsList.count
            case let (.int(lhsInt), .list(_)):
                return Packet.list([Packet.int(lhsInt)]) < rhs
            case let (.list(_), .int(rhsInt)):
                return lhs < Packet.list([Packet.int(rhsInt)])
            }
        }
        
        case int(Int)
        case list([Packet])
        
        init(from decoder: Decoder) throws {
            do {
                let container = try decoder.singleValueContainer()
                self = .int(try container.decode(Int.self))
            } catch {
                self = .list(try [Packet](from: decoder))
            }
        }
    }
    
    func run(input: String) -> String {
        return input.lines
            .map { try! JSONDecoder().decode(Packet.self, from: $0.data(using: .utf8)!) }
            .chunks(ofCount: 2)
            .enumerated()
            .filter { (_, chunk) in
                let lhs = chunk[chunk.startIndex]
                let rhs = chunk[chunk.startIndex.advanced(by: 1)]
                
                return lhs < rhs
            }
            .map { $0.offset + 1 }
            .sum
            .description
    }
}
