//
//  SUOperatingSystemTest.swift
//  Sparkle
//
//  Created by Jozef Izso on 18.10.2023.
//  Copyright © 2023 Cisco Systems, Inc. All rights reserved.
//

@testable import Sparkle
import XCTest

class SUOperatingSystemTest: XCTestCase {

    func test_systemVersionString_matchedExpectedFormat() throws {
        // Arrange
        let expectedFormat = try NSRegularExpression.init(pattern: "\\d+.\\d+.\\d+")

        // Act
        let actualVersionString = SUOperatingSystem.systemVersionString
        let actualMatchCount = expectedFormat.numberOfMatches(in: actualVersionString, range: NSMakeRange(0, actualVersionString.count))
        
        // Assert
        XCTAssertEqual(actualMatchCount, 1)
    }
}
