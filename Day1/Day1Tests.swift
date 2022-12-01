//
//  Day1Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day1Tests: XCTestCase {
    let day = Day1()
    
    func testDay() throws {
        let input =
"""
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
"""
        XCTAssertEqual(day.run(input: input), "24000")
    }
}
