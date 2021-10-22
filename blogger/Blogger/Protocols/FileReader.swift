//
//  FileReader.swift
//  Blogger
//
//  Created by Connor Black on 12/10/2021.
//

import Foundation

protocol FileReader {
    var bundle: Bundle { get }
    func readData(fromFileName fileName: String, withFileType fileType: FileType) throws -> Data
}
