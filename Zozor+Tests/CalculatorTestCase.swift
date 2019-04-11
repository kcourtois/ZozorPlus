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

    //creates calculs alternating one int, one operator.
    func createCalc(numbers: [Int], operators: [Operator]) {
        for (index, num) in numbers.enumerated() {
            _ = calculator.addNewNumber(num)
            let isIndexValid = operators.indices.contains(index)
            if isIndexValid {
                _ = calculator.addNewOperator(newOperator: operators[index])
            }
        }
    }

    // MARK: - Plus Operator

    func testGivenNoValueEntered_WhenAddingPlusOperator_ThenAddNewOperatorShouldReturnFalse() {
        XCTAssertFalse(calculator.addNewOperator(newOperator: .plus))
    }

    func testGivenOnePlusOne_WhenCalculatingTotal_ThenShouldBeTwo() {
        createCalc(numbers: [1, 1], operators: [.plus])

        XCTAssertEqual(calculator.calculateTotal(), 2)
    }

    func testGivenOneInputAndPlusOperator_WhenAddingPlusOperator_ThenAddNewOperatorShouldReturnFalse() {
        createCalc(numbers: [1], operators: [.plus])

        XCTAssertFalse(calculator.addNewOperator(newOperator: .plus))
    }

    func testGiverOneInputAndPlusOperator_WhenAddingPlusOperator_ThenUpdateDisplayIsCorrect() {
        createCalc(numbers: [1], operators: [.plus])

        XCTAssertEqual(calculator.updateDisplay(), "1+")
    }

    // MARK: - Minus Operator

    func testGivenNoValueEntered_WhenAddingMinusOperator_ThenAddNewOperatorShouldReturnFalse() {
        XCTAssertFalse(calculator.addNewOperator(newOperator: .minus))
    }

    func testGivenTwoMinusOne_WhenCalculatingTotal_ThenShouldBeOne() {
        createCalc(numbers: [2, 1], operators: [.minus])

        XCTAssertEqual(calculator.calculateTotal(), 1)
    }

    func testGivenOneInputAndMinusOperator_WhenAddingMinusOperator_ThenAddNewOperatorShouldReturnFalse() {
        createCalc(numbers: [1], operators: [.minus])

        XCTAssertFalse(calculator.addNewOperator(newOperator: .minus))
    }

    func testGivenOneInputAndMinusOperator_WhenAddingMinusOperator_ThenUpdateDisplayIsCorrect() {
        createCalc(numbers: [1], operators: [.minus])

        XCTAssertEqual(calculator.updateDisplay(), "1-")
    }

    // MARK: - Multiply Operator

    func testGivenNoValueEntered_WhenAddingMultiplyOperator_ThenAddNewOperatorShouldReturnFalse() {
        XCTAssertFalse(calculator.addNewOperator(newOperator: .multiply))
    }

    func testGivenThreeTimesThree_WhenCalculatingTotal_ThenShouldBeNine() {
        createCalc(numbers: [3, 3], operators: [.multiply])

        XCTAssertEqual(calculator.calculateTotal(), 9)
    }
    func testGivenThreePlusFourTimesTwoMinusOne_WhenCalculatingTotal_ThenShouldBeTen() {
        createCalc(numbers: [3, 4, 2, 1], operators: [.plus, .multiply, .minus])

        XCTAssertEqual(calculator.calculateTotal(), 10)
    }

    func testGivenOneInputAndMultiplyOperator_WhenAddingMultiplyOperator_ThenAddNewOperatorShouldReturnFalse() {
        createCalc(numbers: [1], operators: [.multiply])

        XCTAssertFalse(calculator.addNewOperator(newOperator: .multiply))
    }

    func testGivenOneInputAndMultiplyOperator_WhenAddingMultiplyOperator_ThenUpdateDisplayIsCorrect() {
        createCalc(numbers: [1], operators: [.multiply])

        XCTAssertEqual(calculator.updateDisplay(), "1*")
    }

    // MARK: - Equal Operator

    func testGivenStringNumbersEmpty_WhenCalculatingTotal_ThenShouldBeNil() {
        XCTAssertEqual(calculator.calculateTotal(), nil)
    }

    func testGivenOneInputAndPlusOperator_WhenCalculatingTotal_ThenAddNewOperatorShouldReturnFalse() {
        createCalc(numbers: [1], operators: [.plus])

        XCTAssertEqual(calculator.calculateTotal(), nil)
    }
}
