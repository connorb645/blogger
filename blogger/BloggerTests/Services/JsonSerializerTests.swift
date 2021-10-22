//
//  JsonDecoderError.swift
//  BloggerTests
//
//  Created by Connor Black on 14/10/2021.
//

import Foundation
import Nimble
import Quick
import XCTest
@testable import Blogger

class JsonSerializerTests: QuickSpec {
    
    override func spec() {
        describe("JsonSerializationService") {
            context("When decoding valid json data to an expected object") {
                
                let bundle = Bundle.init(for: type(of: self))
                let fileReader: FileReader = FileReaderService(bundle: bundle)
                let jsonSerializer: JsonSerializer = JsonSerializerService()
                
                var actual: MockGenericJsonResponse?
                var error: Error?
                
                do {
                    let data = try fileReader.readData(fromFileName: "mockGenericResponse", withFileType: .json)
                    let response: MockGenericJsonResponse = try jsonSerializer.decode(data: data)
                    actual = response
                } catch (let e) {
                    error = e
                }
                
                it("Sets a non nil response") {
                    expect(actual).toNot(beNil())
                }
                
                it("Returns the expected object") {
                    expect(actual).to(beAKindOf(MockGenericJsonResponse.self))
                }
                
                it("Returns the expected values in the response object") {
                    expect(actual!.stringValue).to(equal("Some String"))
                    expect(actual!.intValue).to(equal(10))
                    expect(actual!.boolValue).to(equal(false))
                    expect(actual!.arrayOfStringValue.count).to(equal(2))
                    expect(actual!.arrayOfStringValue[0]).to(equal("String 1"))
                    expect(actual!.arrayOfStringValue[1]).to(equal("String 2"))
                }
                
                it("Does not throw an error") {
                    expect(error).to(beNil())
                }
            }
            
            context("When decoding invalid json data to an expected object") {
                let bundle = Bundle.init(for: type(of: self))
                let fileReader: FileReader = FileReaderService(bundle: bundle)
                let jsonSerializer: JsonSerializer = JsonSerializerService()
                
                var actual: MockGenericJsonResponse?
                var error: Error?
                
                do {
                    let data = try fileReader.readData(fromFileName: "mockInvalidGenericResponse", withFileType: .json)
                    let response: MockGenericJsonResponse = try jsonSerializer.decode(data: data)
                    actual = response
                } catch (let e) {
                    error = e
                }
                
                it("Does not return a valid object") {
                    expect(actual).to(beNil())
                }

                it("Throws the correct error") {
                    expect(error).to(beAKindOf(JsonSerializerError.self))
                    let parsed = error as! JsonSerializerError
                    expect(parsed).to(equal(.decodingFailed(error: nil)))
                }
            }
            
            context("When encoding valid object to data") {
                let jsonSerializer: JsonSerializer = JsonSerializerService()
                
                let modelToEncode = MockGenericJsonResponse(stringValue: "Some String",
                                                            intValue: 10,
                                                            boolValue: true,
                                                            arrayOfStringValue: ["String 1", "String 2"])
                
                var actual: Data?
                var error: Error?
                
                do {
                    actual = try jsonSerializer.encode(object: modelToEncode)
                } catch (let e) {
                    error = e
                }
                
                it("Returns data successfully") {
                    expect(actual).toNot(beNil())
                }

                it("Does not return an error") {
                    expect(error).to(beNil())
                }
            }
            
            context("When creating a json representation of an object") {
                let jsonSerializer: JsonSerializer = JsonSerializerService()
                
                let modelToRepresent = MockGenericJsonResponse(stringValue: "Some String",
                                                            intValue: 10,
                                                            boolValue: true,
                                                            arrayOfStringValue: ["String 1", "String 2"])
                
                var actual: [String: Any]?
                var error: Error?
                
                do {
                    actual = try jsonSerializer.jsonRepresentation(object: modelToRepresent)
                } catch (let e) {
                    error = e
                }
                
                it("Does not return an error") {
                    expect(error).to(beNil())
                }
                
                it("Creates a valid json representation type") {
                    expect(actual).toNot(beNil())
                }
                                
                it("Contains the correct values in the json representation") {
                    expect((actual!["stringValue"] as! String)).to(equal("Some String"))
                    expect((actual!["intValue"] as! Int)).to(equal(10))
                    expect((actual!["boolValue"] as! Bool)).to(equal(true))
                    expect((actual!["arrayOfStringValue"] as! [String])).to(equal(["String 1", "String 2"]))
                }
            }
        }
    }
}
