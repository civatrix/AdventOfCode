//
//  Day4Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day4Tests: XCTestCase {
    let day = Day4()
    
    func testDay() throws {
        let input =
"""
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
"""
        XCTAssertEqual(day.run(input: input), "2")
    }
}
