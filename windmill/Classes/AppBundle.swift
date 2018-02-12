//
//  AppBundle.swift
//  windmill
//
//  Created by Markos Charatzas on 12/2/18.
//  Copyright © 2018 qnoid.com. All rights reserved.
//

import Foundation

struct AppBundle {

    static func make(archiveURL: URL, buildSettings: BuildSettings) -> AppBundle {
        let name = buildSettings.product.name ?? ""
        
        let appBundleURL = archiveURL.appendingPathComponent("Products/Applications/\(name).app")
        
        let info = AppBundle.Info.make(appBundleURL: appBundleURL)
        return AppBundle(url: appBundleURL, info: info)
    }
    
    struct Info {
        
        static func make(appBundleURL url: URL) -> Info {
            let url = url.appendingPathComponent("Info.plist")
            
            return Info(metadata: MetadataPlistEncoded(url: url))
        }

        let metadata: Metadata
        
        var icons: [String: Any]? {
            let icons: [String: Any]? = metadata["CFBundleIcons"]
            
            return icons
        }
        
        var primaryIcon: [String: Any]? {
            let primaryIcon: [String: Any]? = icons?["CFBundlePrimaryIcon"] as? [String: Any]
            
            return primaryIcon
        }
        
        var iconName: String {
            let name = primaryIcon?["CFBundleIconName"] as? String
            
            return name ?? ""
        }
    }
    
    let url: URL
    let info: Info
    
    func iconURL(size: String = "2x") -> URL {
        return url.appendingPathComponent("\(self.info.iconName)60x60@\(size).png")
    }
}
