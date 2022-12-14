//
//  Day14Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day14Tests: XCTestCase {
    let day = Day14()
    
    func testDay() throws {
        let input =
"""
498,4 -> 498,6 -> 496,6
503,4 -> 502,4 -> 502,9 -> 494,9
"""
        XCTAssertEqual(day.run(input: input), "24")
    }
}
