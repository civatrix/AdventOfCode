//
//  Day18Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day18Tests: XCTestCase {
    let day = Day18()
    
    func testDay() throws {
        let input =
"""
2,2,2
1,2,2
3,2,2
2,1,2
2,3,2
2,2,1
2,2,3
2,2,4
2,2,6
1,2,5
3,2,5
2,1,5
2,3,5
"""
        XCTAssertEqual(day.run(input: input), "58")
    }
}
