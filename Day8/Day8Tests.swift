//
//  Day8Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day8Tests: XCTestCase {
    let day = Day8()
    
    func testDay() throws {
        let input =
"""
30373
25512
65332
33549
35390
"""
        XCTAssertEqual(day.run(input: input), "21")
    }
}
