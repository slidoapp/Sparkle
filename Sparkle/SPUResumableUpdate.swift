//
//  SPUResumableUpdate.swift
//  Sparkle
//
//  Created by Jozef Izso on 13.10.2023.
//  Copyright © 2023 Sparkle Project. All rights reserved.
//

import Foundation

@objc
public protocol SPUResumableUpdate {
    var updateItem: SUAppcastItem { get }
    var secondaryUpdateItem: SUAppcastItem? { get }
}
