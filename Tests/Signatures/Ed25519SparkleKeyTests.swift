//
//  Ed25519SparkleKeyTests.swift
//  Sparkle Unit Tests
//
//  Created by Jozef Izso on 12.11.2023.
//  Copyright © 2023 Cisco Systems, Inc. All rights reserved.
//

import XCTest

class Ed25519SparkleKeyTests: XCTestCase {
    // Sample ED25519 Key:
    //   seed: a1111aaacfc876914535947e2a06b838c97cef72fee7e24515caf94ad596ecf0
    //   public key: e22b369181e57c9fa788dc58fbd2a4d1ca8e77671400d30e50a03f4dd7aa59f9
    //
    //   Sparkle private key: b802a5e3f108275f89e6f1230e7ffcf8ed44355b774f6c8d1f677c11a209ea7a87efbcb19fb7a786f97b57386924be4380f52820631e140c19d61a52257dd750e22b369181e57c9fa788dc58fbd2a4d1ca8e77671400d30e50a03f4dd7aa59f9
    //   ED25519 private key: a1111aaacfc876914535947e2a06b838c97cef72fee7e24515caf94ad596ecf0e22b369181e57c9fa788dc58fbd2a4d1ca8e77671400d30e50a03f4dd7aa59f9
    //   ED25519 DER PKCS8: 302e020100300506032b657004220420a1111aaacfc876914535947e2a06b838c97cef72fee7e24515caf94ad596ecf0

    let legacySparkleKey = SparkleKeyExport(
        privateKeyBase64: "uAKl4/EIJ1+J5vEjDn/8+O1ENVt3T2yNH2d8EaIJ6nqH77yxn7enhvl7VzhpJL5DgPUoIGMeFAwZ1hpSJX3XUOIrNpGB5Xyfp4jcWPvSpNHKjndnFADTDlCgP03Xqln5",
        publicKeyBase64: "4is2kYHlfJ+niNxY+9Kk0cqOd2cUANMOUKA/TdeqWfk="
    )
    
    // ed25519 private key in SUPERCOP format `(seed || public_key)`
    let validEd25519PrivateKeyBase64 = "oREaqs/IdpFFNZR+Kga4OMl873L+5+JFFcr5StWW7PDiKzaRgeV8n6eI3Fj70qTRyo53ZxQA0w5QoD9N16pZ+Q=="
    // ed25519 private key in DER format `(DER HEADER || seed)`
    let validEd25519PrivateKeyDerBase64 = "MC4CAQAwBQYDK2VwBCIEIKERGqrPyHaRRTWUfioGuDjJfO9y/ufiRRXK+UrVluzw"
    
    func test_init_import_validBase64PrivateKey() throws {
        // Arrange
        
        // Act
        let key = try Ed25519SparkleKey(import: legacySparkleKey.privateKeyBase64)
        
        // Assert
        XCTAssertEqual(key.privateKey.count, 64)
        XCTAssertEqual(key.publicKey.count, 32)
        
        XCTAssertEqual(key.publicKey.base64EncodedString(), legacySparkleKey.publicKeyBase64)
    }

    func test_init_import_invalidBase64Data_fails() throws {
        // Arrange
        let invalidBase64 = "not valid base64 string"
        
        // Act & Assert
        XCTAssertThrowsError(try Ed25519SparkleKey(import: invalidBase64)){ (err) -> Void in
            let error = err as? PrivateKeyError
            XCTAssertNotNil(error)
        }
    }
    
    func test_init_import_publicKeyInBase64Format_fails() throws {
        // Arrange
        let invalidKey = legacySparkleKey.publicKeyBase64
        
        // Act & Assert
        XCTAssertThrowsError(try Ed25519SparkleKey(import: invalidKey)){ (err) -> Void in
            let error = err as? PrivateKeyError
            XCTAssertNotNil(error)
        }
    }
    
    func test_init_import_privateKeyInBase64Format_fails() throws {
        // Arrange
        let invalidKey = validEd25519PrivateKeyBase64
        
        // Act & Assert
        XCTAssertThrowsError(try Ed25519SparkleKey(import: invalidKey)){ (err) -> Void in
            let error = err as? PrivateKeyError
            XCTAssertNotNil(error)
        }
    }
    
    func test_init_import_privateKeyInDerBase64Format_fails() throws {
        // Arrange
        let invalidKey = validEd25519PrivateKeyDerBase64
        
        // Act & Assert
        XCTAssertThrowsError(try Ed25519SparkleKey(import: invalidKey)){ (err) -> Void in
            let error = err as? PrivateKeyError
            XCTAssertNotNil(error)
        }
    }
    
    struct SparkleKeyExport {
        let privateKeyBase64: String
        let publicKeyBase64: String
    }
}
