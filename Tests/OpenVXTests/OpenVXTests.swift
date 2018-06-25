import XCTest
@testable import OpenVX

final class OpenVXTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(OpenVX().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
