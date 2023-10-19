//
//  SUStandardVersionComparatorTest.swift
//  Sparkle
//
//  Created by Jozef Izso on 18.10.2023.
//  Copyright © 2023 Cisco Systems, Inc. All rights reserved.
//

@testable import Sparkle
import XCTest

class SUStandardVersionComparatorTest: XCTestCase {
    func test_default_comparatorIsAccessibleFromSwift() throws {
        // Arrange & Act
        let actualDefaultComparator = SUStandardVersionComparator.default
        
        // Assert
        XCTAssertNotNil(actualDefaultComparator)
    }
}
