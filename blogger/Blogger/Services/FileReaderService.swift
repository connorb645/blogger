//
//  FileReader.swift
//  Blogger
//
//  Created by Connor Black on 12/10/2021.
//

import Foundation

struct FileReaderService: FileReader {
    let bundle: Bundle
    
    init(bundle: Bundle = Bundle.main) {
        self.bundle = bundle
    }
    
    func readData(fromFileName fileName: String, withFileType fileType: FileType = .json) throws -> Data {
        let path = try path(for: fileName, with: fileType)
        return try read(fromPath: path)
    }
    
    private func path(for fileName: String, with fileType: FileType = .json) throws -> String {
        
        guard !fileName.isEmpty else {
            throw FileReaderError.emptyFileName
        }
        
        guard let path = bundle.path(forResource: fileName, ofType: fileType.rawValue) else {
            throw FileReaderError.invalidFile
        }
        
        return path
    }
    
    private func read(fromPath filePath: String) throws -> Data {
        do {
            return try Data(contentsOf: URL(fileURLWithPath: filePath))
        } catch (let error) {
            throw FileReaderError.fileReadError(error: error)
        }
    }
    
}

