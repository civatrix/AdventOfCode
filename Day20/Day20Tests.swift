//
//  Day20Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day20Tests: XCTestCase {
    let day = Day20()
    
    func testDay() throws {
        let input =
"""
1
2
-3
3
-2
0
4
"""
        XCTAssertEqual(day.run(input: input), "1623178306")
    }
}
