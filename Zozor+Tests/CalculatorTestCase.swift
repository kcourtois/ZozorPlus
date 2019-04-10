//
//  CalculatorTestCase.swift
//  CountOnMeTests
//
//  Created by Kévin Courtois on 10/04/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculatorTestCase: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testGivenInstanceOfCalculator_WhenAccessingIt_ThenItExists() {
        let calculator = Calculator()
        XCTAssertNotNil(calculator)
    }
}
