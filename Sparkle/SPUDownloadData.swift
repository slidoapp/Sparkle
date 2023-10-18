//
//  SPUDownloadData.swift
//  Sparkle
//
//  Created by Jozef Izso on 15.10.2023.
//  Copyright © 2023 Sparkle Project. All rights reserved.
//  Copyright © 2023 Cisco Systems, Inc. All rights reserved.
//

import Foundation

/**
 * A class for containing downloaded data along with some information about it.
 */
public class SPUDownloadData: NSObject, NSSecureCoding {
    @objc public let data: Data
    @objc public let URL: URL
    @objc public let textEncodingName: String?
    @objc public let MIMEType: String?
    
    @objc public init(withData data: Data, URL: URL, textEncodingName: String?, MIMEType: String?) {
        self.data = data
        self.URL = URL
        self.textEncodingName = textEncodingName
        self.MIMEType = MIMEType
    }
    
    // MARK: NSSecureCoding members
    static let SPUDownloadDataKey = "SPUDownloadData"
    static let SPUDownloadURLKey = "SPUDownloadURL"
    static let SPUDownloadTextEncodingKey = "SPUDownloadTextEncoding"
    static let SPUDownloadMIMETypeKey = "SPUDownloadMIMEType"

    public static var supportsSecureCoding: Bool {
        true
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.data, forKey: SPUDownloadData.SPUDownloadDataKey)
        coder.encode(self.URL, forKey: SPUDownloadData.SPUDownloadURLKey)
        coder.encode(self.textEncodingName, forKey: SPUDownloadData.SPUDownloadTextEncodingKey)
        coder.encode(self.MIMEType, forKey: SPUDownloadData.SPUDownloadMIMETypeKey)
    }
    
    public required init?(coder: NSCoder) {
        guard let data = coder.decodeObject(forKey: SPUDownloadData.SPUDownloadDataKey) as? Data,
              let URL = coder.decodeObject(forKey: SPUDownloadData.SPUDownloadURLKey) as? URL
        else {
            return nil
        }
        
        let textEncodingName = coder.decodeObject(forKey: SPUDownloadData.SPUDownloadTextEncodingKey) as? String
        let MIMEType = coder.decodeObject(forKey: SPUDownloadData.SPUDownloadMIMETypeKey) as? String

        self.data = data
        self.URL = URL
        self.textEncodingName = textEncodingName
        self.MIMEType = MIMEType
    }
    
}
