//
//  SUVersionComparison.swift
//  Sparkle
//
//  Created by Jozef Izso on 18.10.2023.
//  Copyright 2007 Andy Matuschak. All rights reserved.
//  Copyright © 2023 Cisco Systems, Inc. All rights reserved.
//

import Foundation

/**
    Provides version comparison facilities for Sparkle.
*/
@objc
public protocol SUVersionComparison {
    /**
        An abstract method to compare two version strings.

        Should return NSOrderedAscending if b > a, NSOrderedDescending if b < a,
        and NSOrderedSame if they are equivalent.
    */
    @objc func compareVersion(_ versionA: String, toVersion versionB: String) -> ComparisonResult
}
