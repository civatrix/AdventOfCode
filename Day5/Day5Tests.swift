//
//  Day5Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day5Tests: XCTestCase {
    let day = Day5()
    
    func testDay() throws {
        let input =
"""
    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
"""
        XCTAssertEqual(day.run(input: input), "CMZ")
    }
}
