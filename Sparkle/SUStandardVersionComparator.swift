//
//  SUStandardVersionComparator.swift
//  Sparkle
//
//  Created by Jozef Izso on 18.10.2023.
//  Copyright 2007 Andy Matuschak. All rights reserved.
//  Copyright © 2023 Cisco Systems, Inc. All rights reserved.
//

import Foundation

/**
    Sparkle's default version comparator.

    This comparator is adapted from MacPAD, by Kevin Ballard.
    It's "dumb" in that it does essentially string comparison,
    in components split by character type.
*/
public class SUStandardVersionComparator: NSObject, SUVersionComparison {
    /**
        A singleton instance of the comparator.
     */
    @objc(defaultComparator)
    public static let `default` = SUStandardVersionComparator()
    
    /**
        Initializes a new instance of the standard version comparator.
    */
    public override init() {
    }
    
    enum SUCharacterType {
        case numberType
        case stringType
        case periodSeparatorType
        case punctuationSeparatorType
        case whitespaceSeparatorType
        case dashType
    }
    
    func typeOfCharacter(_ string: String) -> SUCharacterType {
        let character = string[string.startIndex]
        return self.typeOfCharacter(character)
    }
    
    func typeOfCharacter(_ character: Character) -> SUCharacterType {
        if character == "." {
            return .periodSeparatorType
        } else if character == "-" {
            return .dashType
        }

        guard let characterScalar = character.unicodeScalars.first else {
            return .stringType
        }
        
        if CharacterSet.decimalDigits.contains(characterScalar) {
            return .numberType
        } else if CharacterSet.whitespacesAndNewlines.contains(characterScalar) {
            return .whitespaceSeparatorType
        } else if CharacterSet.punctuationCharacters.contains(characterScalar) {
            return .punctuationSeparatorType
        } else {
            return .stringType
        }
    }
    
    func isSeparatorType(characterType: SUCharacterType) -> Bool {
        switch characterType {
        case .numberType, .stringType, .dashType:
            return false
        case .periodSeparatorType, .punctuationSeparatorType, .whitespaceSeparatorType:
            return true
        }
    }
    
    /// If type A and type B are some sort of separator, consider them to be equal
    func isEqualCharacterTypeClassForTypeA(typeA: SUCharacterType, typeB: SUCharacterType) -> Bool {
        switch typeA {
        case .numberType, .stringType, .dashType:
            return (typeA == typeB)
        case .periodSeparatorType, .punctuationSeparatorType, .whitespaceSeparatorType:
            switch typeB {
            case .periodSeparatorType, .punctuationSeparatorType, .whitespaceSeparatorType:
                return true
            case .numberType, .stringType, .dashType:
                return false
            }
        }
    }
    
    func splitVersion(string version: String) -> [String] {
        var s: String
        var oldType: SUCharacterType
        var newType: SUCharacterType
        var parts: [String] = []
        
        if version.count == 0 {
            // Nothing to do here
            return []
        }
        
        s = String(version.prefix(1))
        oldType = self.typeOfCharacter(s)
        
        for character in version.dropFirst() {
            newType = self.typeOfCharacter(character)
            if newType == .dashType {
                break
            }
            if oldType != newType || self.isSeparatorType(characterType: oldType) {
                // We've reached a new segment
                parts.append(s)
                s = String(character)
            } else {
                // Add character to string and continue
                s.append(character)
            }
            oldType = newType
        }
        
        // Add the last part onto the array
        parts.append(s)
        return parts
    }
    
    /// This returns the count of number and period parts at the beginning of the version
    /// See -balanceVersionPartsA:partsB below
    func countOfNumberAndPeriodStartingParts(_ parts: [String]) -> Int {
        var count = 0
        for part in parts {
            let characterType = self.typeOfCharacter(part)
            if characterType == .numberType || characterType == .periodSeparatorType {
                count += 1
            } else {
                break
            }
        }

        return count
    }
    
    func addNumberAndPeriodParts(to toParts: inout [String], toNumberAndPeriodPartsCount: Int, from fromParts: [String], fromNumberAndPeriodPartsCount: Int) {
        let partsCountDifference = fromNumberAndPeriodPartsCount - toNumberAndPeriodPartsCount
        
        for insertionIndex in toNumberAndPeriodPartsCount ..< (toNumberAndPeriodPartsCount + partsCountDifference) {
            let character = fromParts[insertionIndex]
            let typeA = typeOfCharacter(character)
            if typeA == .periodSeparatorType {
                toParts.insert(".", at: insertionIndex)
            } else if typeA == .numberType {
                toParts.insert("0", at: insertionIndex)
            } else {
                // It should not be possible to get here
                assertionFailure("Cannot add non numeric character \(character) to version part.")
            }
        }
    }
    
    /// If one version starts with "1.0.0" and the other starts with "1.1" we make sure they're balanced
    /// such that the latter version now becomes "1.1.0". This helps ensure that versions like "1.0" and "1.0.0" are equal.
    func balanceVersionParts(partsA: inout [String], partsB: inout [String]) {
        let partANumberAndPeriodPartsCount = self.countOfNumberAndPeriodStartingParts(partsA)
        let partBNumberAndPeriodPartsCount = self.countOfNumberAndPeriodStartingParts(partsB)
        
        if partANumberAndPeriodPartsCount > partBNumberAndPeriodPartsCount {
            self.addNumberAndPeriodParts(to: &partsB, toNumberAndPeriodPartsCount: partBNumberAndPeriodPartsCount, from: partsA, fromNumberAndPeriodPartsCount: partANumberAndPeriodPartsCount)
        } else if partBNumberAndPeriodPartsCount > partANumberAndPeriodPartsCount {
            self.addNumberAndPeriodParts(to: &partsA, toNumberAndPeriodPartsCount: partANumberAndPeriodPartsCount, from: partsB, fromNumberAndPeriodPartsCount: partBNumberAndPeriodPartsCount)
        }
    }
    
    // MARK: SUVersionComparison members
    
    /**
        Compares two version strings through textual analysis.
     
        These version strings should be in the format of x, x.y, or x.y.z where each component is a number.
        For example, valid version strings include "1.5.3", "500", or "4000.1"
        These versions that are compared correspond to the @c CFBundleVersion values of the updates.
     
        @param versionA The first version string to compare.
        @param versionB The second version string to compare.
        @return A comparison result between @c versionA and @c versionB
    */
    public func compareVersion(_ versionA: String, toVersion versionB: String) -> ComparisonResult {
        var splitPartsA = self.splitVersion(string: versionA)
        var splitPartsB = self.splitVersion(string: versionB)
        
        self.balanceVersionParts(partsA: &splitPartsA, partsB: &splitPartsB)

        return .orderedSame
    }
}
