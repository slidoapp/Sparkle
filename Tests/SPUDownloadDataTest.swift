//
//  SPUDownloadDataTest.swift
//  Sparkle
//
//  Created by Jozef Izso on 18.10.2023.
//  Copyright © 2023 Cisco Systems, Inc. All rights reserved.
//


@testable import Sparkle
import XCTest

class SPUDownloadDataTest: XCTestCase {

    func testEncode() throws {
        // Arrange
        let data = Data()
        let url = URL(string: "https://example.org")!

        let downloadData = SPUDownloadData(withData: data, URL: url, textEncodingName: nil, MIMEType: nil)
        
        let coder = NSKeyedArchiver(requiringSecureCoding: true)

        // Act
        downloadData.encode(with: coder)
        
        // Assert
        let decoder = try NSKeyedUnarchiver(forReadingFrom: coder.encodedData)
        let actualData = decoder.decodeObject(forKey: SPUDownloadData.SPUDownloadDataKey) as? Data
        
        XCTAssertNotNil(actualData)
    }
    
    func testDecodeEmptyEncodedDataReturnsNilObject() throws {
        // Arrange
        let coder = NSKeyedArchiver(requiringSecureCoding: true)
        let decoder = try NSKeyedUnarchiver(forReadingFrom: coder.encodedData)

        // Act
        let actualDownloadData = SPUDownloadData(coder: decoder)
        
        // Assert
        XCTAssertNil(actualDownloadData)
    }
    
    func testDecodeMissingDataMemberReturnsNilObject() throws {
        // Arrange
        let url = URL(string: "https://example.org")!

        let coder = NSKeyedArchiver(requiringSecureCoding: true)
        coder.encode(url, forKey: SPUDownloadData.SPUDownloadURLKey)
        
        let decoder = try NSKeyedUnarchiver(forReadingFrom: coder.encodedData)

        // Act
        let actualDownloadData = SPUDownloadData(coder: decoder)
        
        // Assert
        XCTAssertNil(actualDownloadData)
    }
    
    func testDecodeMissingURLMemberReturnsNilObject() throws {
        // Arrange
        let data = Data()

        let coder = NSKeyedArchiver(requiringSecureCoding: true)
        coder.encode(data, forKey: SPUDownloadData.SPUDownloadDataKey)
        
        let decoder = try NSKeyedUnarchiver(forReadingFrom: coder.encodedData)

        // Act
        let actualDownloadData = SPUDownloadData(coder: decoder)
        
        // Assert
        XCTAssertNil(actualDownloadData)
    }
}
