//
//  FileReaderError.swift
//  Blogger
//
//  Created by Connor Black on 12/10/2021.
//

import Foundation

enum FileReaderError: Error, Equatable {
    case invalidFile
    case emptyFileName
    case fileReadError(error: Error)
    
    static func == (lhs: FileReaderError, rhs: FileReaderError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidFile, .invalidFile): return true
        case (.emptyFileName, .emptyFileName): return true
        case (.fileReadError(let le), .fileReadError(let re)):
            return String(reflecting: le) == String(reflecting: re)
        default: return false
        }
    }
}
