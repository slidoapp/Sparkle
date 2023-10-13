//
//  SPUInformationalUpdate.swift
//  Sparkle
//
//  Created by Jozef Izso on 13.10.2023.
//  Copyright © 2023 Cisco Systems, Inc. All rights reserved.
//

import Foundation

public class SPUInformationalUpdate: NSObject, SPUResumableUpdate {
    public let updateItem: SUAppcastItem
    public let secondaryUpdateItem: SUAppcastItem?
    
    @objc
    public init(appcastItem updateItem: SUAppcastItem, secondaryAppcastItem secondaryUpdateItem: SUAppcastItem?) {
        self.updateItem = updateItem
        self.secondaryUpdateItem = secondaryUpdateItem
    }
}
