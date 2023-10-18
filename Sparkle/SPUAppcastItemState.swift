//
//  SPUAppcastItemState.swift
//  Sparkle
//
//  Created by Jozef Izso on 17.10.2023.
//  Copyright © 2021 Sparkle Project. All rights reserved.
//  Copyright © 2023 Cisco Systems, Inc. All rights reserved.
//

import Foundation

public class SPUAppcastItemState: NSObject, NSSecureCoding {
    @objc public let majorUpgrade: Bool;
    @objc public let criticalUpdate: Bool;
    @objc public let informationalUpdate: Bool;
    @objc public let minimumOperatingSystemVersionIsOK: Bool;
    @objc public let maximumOperatingSystemVersionIsOK: Bool;

    @objc public init(withMajorUpgrade majorUpgrade: Bool, criticalUpdate: Bool, informationalUpdate: Bool, minimumOperatingSystemVersionIsOK: Bool, maximumOperatingSystemVersionIsOK: Bool) {
        self.majorUpgrade = majorUpgrade;
        self.criticalUpdate = criticalUpdate;
        self.informationalUpdate = informationalUpdate;
        self.minimumOperatingSystemVersionIsOK = minimumOperatingSystemVersionIsOK;
        self.maximumOperatingSystemVersionIsOK = maximumOperatingSystemVersionIsOK;
    }
    
    // MARK: NSSecureCoding members
    static let SPUAppcastItemStateMajorUpgradeKey = "SPUAppcastItemStateMajorUpgrade"
    static let SPUAppcastItemStateCriticalUpdateKey = "SPUAppcastItemStateCriticalUpdate"
    static let SPUAppcastItemStateInformationalUpdateKey = "SPUAppcastItemStateInformationalUpdate"
    static let SPUAppcastItemStateMinimumOperatingSystemVersionIsOKKey = "SPUAppcastItemStateMinimumOperatingSystemVersionIsOK"
    static let SPUAppcastItemStateMaximumOperatingSystemVersionIsOKKey = "SPUAppcastItemStateMaximumOperatingSystemVersionIsOK"
    
    public static var supportsSecureCoding: Bool {
        true
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(majorUpgrade, forKey: SPUAppcastItemState.SPUAppcastItemStateMajorUpgradeKey)
        coder.encode(criticalUpdate, forKey: SPUAppcastItemState.SPUAppcastItemStateCriticalUpdateKey)
        coder.encode(informationalUpdate, forKey: SPUAppcastItemState.SPUAppcastItemStateInformationalUpdateKey)
        coder.encode(minimumOperatingSystemVersionIsOK, forKey: SPUAppcastItemState.SPUAppcastItemStateMinimumOperatingSystemVersionIsOKKey)
        coder.encode(maximumOperatingSystemVersionIsOK, forKey: SPUAppcastItemState.SPUAppcastItemStateMaximumOperatingSystemVersionIsOKKey)
    }
    
    public required init?(coder: NSCoder) {
        let majorUpgrade = coder.decodeBool(forKey: SPUAppcastItemState.SPUAppcastItemStateMajorUpgradeKey)
        let criticalUpdate = coder.decodeBool(forKey: SPUAppcastItemState.SPUAppcastItemStateCriticalUpdateKey)
        let informationalUpdate = coder.decodeBool(forKey: SPUAppcastItemState.SPUAppcastItemStateInformationalUpdateKey)
        let minimumOperatingSystemVersionIsOK = coder.decodeBool(forKey: SPUAppcastItemState.SPUAppcastItemStateMinimumOperatingSystemVersionIsOKKey)
        let maximumOperatingSystemVersionIsOK = coder.decodeBool(forKey: SPUAppcastItemState.SPUAppcastItemStateMaximumOperatingSystemVersionIsOKKey)
        
        self.majorUpgrade = majorUpgrade;
        self.criticalUpdate = criticalUpdate;
        self.informationalUpdate = informationalUpdate;
        self.minimumOperatingSystemVersionIsOK = minimumOperatingSystemVersionIsOK;
        self.maximumOperatingSystemVersionIsOK = maximumOperatingSystemVersionIsOK;
    }
}
