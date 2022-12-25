//
//  Day25Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day25Tests: XCTestCase {
    let day = Day25()
    
    func testDay() throws {
        let input =
"""
1=-0-2
12111
2=0=
21
2=01
111
20012
112
1=-1=
1-12
12
1=
122
"""
        XCTAssertEqual(day.run(input: input), "2=-1=0")
    }
    
    func test2022() throws {
        XCTAssertEqual(2022.snafu, "1=11-2")
    }
}
