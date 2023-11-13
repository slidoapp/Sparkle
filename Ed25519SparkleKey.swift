//
//  Ed25519SparkleKey.swift
//  generate_keys
//
//  Created by Jozef Izso on 12.11.2023.
//  Copyright © 2023 Cisco Systems, Inc. All rights reserved.
//

import Foundation

/// Sparkle implementation of Ed25519 key from `orlp/ed25519`.
///
/// This is an elliptic curve Ed25519 implementation based
/// on the SUPERCOP "ref10" implementation.
///
/// @note The orlp/ed25519 library stores private keys in a different format
/// than other libraries. The "orlp private key" has format `(alpha || public_key)`
/// where `alpha` is private scalar concatenated with the "right half".
/// The orlp private key has length of 96 bytes.
///
/// Other libraries use private key format `(seed || public_key)`
/// with length of 64 bytes.
///
/// If you wish to be compatible with these libraries you must keep the seed around.
struct Ed25519SparkleKey {
    let publicKey: Data
    let privateKey: Data
    
    init(publicKey: Data, privateKey: Data) {
        self.publicKey = publicKey
        self.privateKey = privateKey
    }
    
    init(import base64OPrivateKey: String) throws {
        guard let privateAndPublicKey = Data(base64Encoded: base64OPrivateKey.trimmingCharacters(in: .whitespacesAndNewlines), options: .init()) else {
            throw PrivateKeyError.invalidFormat("Failed to decode base64 encoded key data from: \(base64OPrivateKey)")
        }
        
        guard privateAndPublicKey.count == 64 + 32 else {
            throw PrivateKeyError.invalidFormat("Imported key must be 96 bytes decoded. Instead it is \(privateAndPublicKey.count) bytes decoded.")
        }
        
        self.publicKey = privateAndPublicKey[64...]
        self.privateKey = privateAndPublicKey[0..<64]
    }
    
    var publicKeyBase64: String {
        self.publicKey.base64EncodedString()
    }
    
    var privateKeyBase64Data: Data {
        (self.privateKey + self.publicKey).base64EncodedData()
    }
}

enum PrivateKeyError: Error {
    case invalidFormat(String)
}
