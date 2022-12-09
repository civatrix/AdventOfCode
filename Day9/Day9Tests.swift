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
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
"""
        XCTAssertEqual(day.run(input: input), "13")
    }
}
