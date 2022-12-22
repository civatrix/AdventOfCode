//
//  Day22Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day22Tests: XCTestCase {
    let day = Day22()
    
    func testDay() throws {
        let input =
"""
        ...#
        .#..
        #...
        ....
...#.......#
........#...
..#....#....
..........#.
        ...#....
        .....#..
        .#......
        ......#.

10R5L5R10L4R5L5
"""
        XCTAssertEqual(day.run(input: input), "6032")
    }
}
