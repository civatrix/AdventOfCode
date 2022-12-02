//
//  Day2Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day2Tests: XCTestCase {
    let day = Day2()
    
    func testDay() throws {
        let input =
"""
A Y
B X
C Z
"""
        XCTAssertEqual(day.run(input: input), "12")
    }
}
