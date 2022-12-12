//
//  Day12Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day12Tests: XCTestCase {
    let day = Day12()
    
    func testDay() throws {
        let input =
"""
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
"""
        XCTAssertEqual(day.run(input: input), "31")
    }
}
