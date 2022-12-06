//
//  Day6Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day6Tests: XCTestCase {
    let day = Day6()
    
    func testDay() throws {
        let input =
"""
bvwbjplbgvbhsrlpgdmjqwftvncz
"""
        XCTAssertEqual(day.run(input: input), "23")
    }
    
    func testDay2() throws {
        let input =
"""
nppdvjthqldpwncqszvftbrmjlhg
"""
        XCTAssertEqual(day.run(input: input), "23")
    }
    
    func testDay3() throws {
        let input =
"""
nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg
"""
        XCTAssertEqual(day.run(input: input), "29")
    }
    
    func testDay4() throws {
        let input =
"""
zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw
"""
        XCTAssertEqual(day.run(input: input), "26")
    }
}
