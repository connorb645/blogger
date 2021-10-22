//
//  FileReaderTests.swift
//  BloggerTests
//
//  Created by Connor Black on 12/10/2021.
//

import XCTest
@testable import Blogger

class FileReaderTests: XCTestCase {
        
    func testCanReadDataFromFile() {
        let bundle = Bundle.init(for: type(of: self))
        let fileReader: FileReader = FileReaderService(bundle: bundle)
        
        do {
            let data = try fileReader.readData(fromFileName: "mockBlogPostResponse", withFileType: .json)
            
            XCTAssertNotNil(data)
            XCTAssertFalse(data.isEmpty)
        } catch {
            XCTFail("File Reader threw an error")
        }
    }
    
    func testInvalidFileNameReturnsCorrectError() {
        let bundle = Bundle.init(for: type(of: self))
        let fileReader: FileReader = FileReaderService(bundle: bundle)
        
        do {
            _ = try fileReader.readData(fromFileName: "missingFile", withFileType: .json)
            
            XCTFail("Requesting data from unknown file didn't throw an error when it should have.")
        } catch(let error) {
            guard let parsedError = error as? FileReaderError else {
                XCTFail("Error type is not as expected")
                return
            }
            
            XCTAssertEqual(parsedError, FileReaderError.invalidFile)
        }
    }
    
    func testEmptyFileNameReturnsCorrectError() {
        let bundle = Bundle.init(for: type(of: self))
        let fileReader: FileReader = FileReaderService(bundle: bundle)
        
        do {
            _ = try fileReader.readData(fromFileName: "", withFileType: .json)
            
            XCTFail("Requesting data from unknown file didn't throw an error when it should have.")
        } catch(let error) {
            guard let parsedError = error as? FileReaderError else {
                XCTFail("Error type is not as expected")
                return
            }
            
            XCTAssertEqual(parsedError, FileReaderError.emptyFileName)
        }
    }

}
