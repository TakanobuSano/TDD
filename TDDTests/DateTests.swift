//
//  DateTests.swift
//  TDDTests
//
//  Created by 佐野貴信 on 2022/04/29.
//

import XCTest
@testable import TDD

class DateTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    ///DateModelのモック
    struct MockDateModel: DateProtocol {
        var date: Date? = nil
        func now() -> Date {
            return date!
        }
    }

    func testIsHoliday() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        var mock = MockDateModel()
        
        mock.date = formatter.date(from: "2019/10/05")
        XCTAssertTrue(DateViewModel(dateModel: mock).isHoliday(), "土曜日のテスト")
        
        mock.date = formatter.date(from: "2019/10/06")
        XCTAssertTrue(DateViewModel(dateModel: mock).isHoliday(), "日曜日のテスト")
        
        mock.date = formatter.date(from: "2019/10/07")
        XCTAssertFalse(DateViewModel(dateModel: mock).isHoliday(), "月曜日のテスト")
        
        XCTAssertTrue(DateViewModel().isHoliday(), "土曜日のテスト")

    }

}
