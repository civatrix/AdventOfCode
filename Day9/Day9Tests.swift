//
//  Day9Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day9Tests: XCTestCase {
    let day = Day9()
    
    func testDay() throws {
        let input =
"""
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
"""
        XCTAssertEqual(day.run(input: input), "36")
    }
}
