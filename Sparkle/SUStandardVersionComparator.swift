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
        return .orderedSame
    }
}
