//
//  SUOperatingSystem.swift
//  Sparkle
//
//  Created by Jozef Izso on 15.10.2023.
//  Copyright © 2015 Sparkle Project. All rights reserved.
//  Copyright © 2023 Cisco Systems, Inc. All rights reserved.
//

import Foundation

public class SUOperatingSystem: NSObject {
    @objc public static var systemVersionString: String {
        let version = ProcessInfo.processInfo.operatingSystemVersion
        return String(format: "%ld.%ld.%ld", version.majorVersion, version.minorVersion, version.patchVersion)
    }
}
