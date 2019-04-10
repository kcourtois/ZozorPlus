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

    var calculator: Calculator!

    override func setUp() {
        calculator = Calculator()
    }

    // MARK: - Plus Operator

    func testGivenNoValueEntered_WhenAddingPlusOperator_ThenAddNewOperatorShouldReturnFalse() {
        XCTAssertFalse(calculator.addNewOperator(newOperator: .plus))
    }

    func testGivenOnePlusOne_WhenCalculatingTotal_ThenShouldBeTwo() {
        XCTAssertTrue(calculator.addNewNumber(1))
        XCTAssertTrue(calculator.addNewOperator(newOperator: .plus))
        XCTAssertTrue(calculator.addNewNumber(1))

        XCTAssertEqual(calculator.calculateTotal(), 2)
    }

    func testGivenOneInputAndPlusOperator_WhenAddingPlusOperator_ThenAddNewOperatorShouldReturnFalse() {
        XCTAssertTrue(calculator.addNewNumber(1))
        XCTAssertTrue(calculator.addNewOperator(newOperator: .plus))

        XCTAssertFalse(calculator.addNewOperator(newOperator: .plus))
    }

    func testGiverOneInputAndPlusOperator_WhenAddingPlusOperator_ThenUpdateDisplayIsCorrect() {
        XCTAssertTrue(calculator.addNewNumber(1))
        XCTAssertTrue(calculator.addNewOperator(newOperator: .plus))

        XCTAssertEqual(calculator.updateDisplay(), "1+")
    }

    // MARK: - Minus Operator

    func testGivenNoValueEntered_WhenAddingMinusOperator_ThenAddNewOperatorShouldReturnFalse() {
        XCTAssertFalse(calculator.addNewOperator(newOperator: .minus))
    }

    func testGivenTwoMinusOne_WhenCalculatingTotal_ThenShouldBeOne() {
        XCTAssertTrue(calculator.addNewNumber(2))
        XCTAssertTrue(calculator.addNewOperator(newOperator: .minus))
        XCTAssertTrue(calculator.addNewNumber(1))

        XCTAssertEqual(calculator.calculateTotal(), 1)
    }

    func testGivenOneInputAndMinusOperator_WhenAddingMinusOperator_ThenAddNewOperatorShouldReturnFalse() {
        XCTAssertTrue(calculator.addNewNumber(1))
        XCTAssertTrue(calculator.addNewOperator(newOperator: .minus))

        XCTAssertFalse(calculator.addNewOperator(newOperator: .minus))
    }

    func testGivenOneInputAndMinusOperator_WhenAddingMinusOperator_ThenUpdateDisplayIsCorrect() {
        XCTAssertTrue(calculator.addNewNumber(1))
        XCTAssertTrue(calculator.addNewOperator(newOperator: .minus))

        XCTAssertEqual(calculator.updateDisplay(), "1-")
    }

    // MARK: - Equal Operator

    func testGivenStringNumbersEmpty_WhenCalculatingTotal_ThenShouldBeNil() {
        XCTAssertEqual(calculator.calculateTotal(), nil)
    }

    func testGivenOneInputAndPlusOperator_WhenCalculatingTotal_ThenAddNewOperatorShouldReturnFalse() {
        XCTAssertTrue(calculator.addNewNumber(1))
        XCTAssertTrue(calculator.addNewOperator(newOperator: .plus))

        XCTAssertEqual(calculator.calculateTotal(), nil)
    }
}
