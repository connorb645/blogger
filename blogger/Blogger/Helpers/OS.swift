//
//  OSService.swift
//  Blogger
//
//  Created by Connor Black on 26/10/2021.
//

import Foundation

enum OSType {
    case macOS, iOS
}

struct OS {
    static var current: OSType {
        #if os(iOS)
        return .macOS
        #else
        return .iOS
        #endif
    }
}
