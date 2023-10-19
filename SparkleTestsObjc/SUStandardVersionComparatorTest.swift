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
    func test_init_standardComparatorCanBeInitialized() throws {
        // Arrange & Act
        let actualtComparator = SUStandardVersionComparator()
        
        // Assert
        XCTAssertNotNil(actualtComparator)
    }

    func test_default_comparatorIsAccessibleFromSwift() throws {
        // Arrange & Act
        let actualDefaultComparator = SUStandardVersionComparator.default
        
        // Assert
        XCTAssertNotNil(actualDefaultComparator)
    }
    
    // MARK: func typeOfCharacter(_ character: String) tests
    func test_typeOfCharacter_periodSeparator() {
        let comparator = SUStandardVersionComparator()
        
        // Act
        let actualCharacterType = comparator.typeOfCharacter(".")
        
        // Assert
        XCTAssertEqual(actualCharacterType, SUStandardVersionComparator.SUCharacterType.periodSeparatorType)
    }
    
    func test_typeOfCharacter_dash() {
        let comparator = SUStandardVersionComparator()
        
        // Act
        let actualCharacterType = comparator.typeOfCharacter("-")
        
        // Assert
        XCTAssertEqual(actualCharacterType, SUStandardVersionComparator.SUCharacterType.dashType)
    }
    
    func test_typeOfCharacter_number() {
        let comparator = SUStandardVersionComparator()
        
        // Act
        let actualCharacterType = comparator.typeOfCharacter("1")
        
        // Assert
        XCTAssertEqual(actualCharacterType, SUStandardVersionComparator.SUCharacterType.numberType)
    }
    
    func test_typeOfCharacter_whitespace() {
        let comparator = SUStandardVersionComparator()
        
        // Act
        let actualCharacterType = comparator.typeOfCharacter(" ")
        
        // Assert
        XCTAssertEqual(actualCharacterType, SUStandardVersionComparator.SUCharacterType.whitespaceSeparatorType)
    }
    
    func test_typeOfCharacter_punctuationSeparator() {
        let comparator = SUStandardVersionComparator()
        
        // Act
        let actualCharacterType = comparator.typeOfCharacter("(")
        
        // Assert
        XCTAssertEqual(actualCharacterType, SUStandardVersionComparator.SUCharacterType.punctuationSeparatorType)
    }
    
    func test_typeOfCharacter_string() {
        let comparator = SUStandardVersionComparator()
        
        // Act
        let actualCharacterType = comparator.typeOfCharacter("")
        
        // Assert
        XCTAssertEqual(actualCharacterType, SUStandardVersionComparator.SUCharacterType.stringType)
    }
    
    // MARK: func countOfNumberAndPeriodStartingParts tests
    func test_countOfNumberAndPeriodStartingParts_simpleNumericVersion() {
        let comparator = SUStandardVersionComparator()
        let parts = ["1", ".", "0"]
        
        // Act
        let actualCount = comparator.countOfNumberAndPeriodStartingParts(parts)
        
        // Assert
        XCTAssertEqual(actualCount, 3)
    }
    
    // MARK: func splitVersion
    func test_splitVersion() {
        let comparator = SUStandardVersionComparator()
        
        // Act
        let actualParts = comparator.splitVersion(string: "1.0.0 (1234)")
        
        // Assert
        XCTAssertEqual(actualParts.count, 4)
    }
}
