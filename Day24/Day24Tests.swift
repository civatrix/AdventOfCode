//
//  Day24Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day24Tests: XCTestCase {
    let day = Day24()
    
    func testDay() throws {
        let input =
"""
#.######
#>>.<^<#
#.<..<<#
#>v.><>#
#<^v^^>#
######.#
"""
        XCTAssertEqual(day.run(input: input), "18")
    }
    
    func testWind() throws {
        let windStarts: [Point: Set<Point>] = [
            .up: [[1,1]],
            .down: [[1,1]],
            .left: [[1,1]],
            .right: [[1,1]],
        ]
        
        XCTAssertEqual(day.windPositions(at: 1, starts: windStarts, width: 10, height: 10), [[1, 10], [2, 1], [1, 2], [10, 1]])
        XCTAssertEqual(day.windPositions(at: 5, starts: windStarts, width: 10, height: 10), [[1, 6], [6, 1], [1, 6], [6, 1]])
        XCTAssertEqual(day.windPositions(at: 10, starts: windStarts, width: 10, height: 10), [[1, 1]])
        XCTAssertEqual(day.windPositions(at: 11, starts: windStarts, width: 10, height: 10), [[1, 10], [2, 1], [1, 2], [10, 1]])
        XCTAssertEqual(day.windPositions(at: 62, starts: windStarts, width: 10, height: 10), [[1, 9], [3, 1], [1, 3], [9, 1]])
    }
    
    func testSampleWind() throws {
        let windStarts: [Point: Set<Point>] = [
            .up: [[5,1], [2,4], [4,4], [5,4]],
            .down: [[1,1], [2,3], [3,4]],
            .left: [[4,1], [6,1], [2,2], [5,2], [6,2], [5,3], [1,4]],
            .right: [[1,1], [2,1], [1,3], [4,3], [6,3], [6,4]],
        ]
        
        let wind1 = day.windPositions(at: 1, starts: windStarts, width: 6, height: 4)
        wind1.printPoints()
        XCTAssertEqual(wind1, [[2, 1], [3, 1], [5, 1], [1, 2], [5, 2], [4, 2], [1, 3], [2, 3], [4, 3], [5, 3], [1, 4], [2, 4], [5, 4], [6, 4]])
    }
}
