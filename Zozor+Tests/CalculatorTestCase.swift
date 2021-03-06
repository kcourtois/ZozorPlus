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
    private func createCalc(numbers: [Int], operators: [Operator]) {
        for (index, num) in numbers.enumerated() {
            _ = calculator.addNewNumber(num)
            let isIndexValid = operators.indices.contains(index)
            if isIndexValid {
                _ = calculator.addNewOperator(newOperator: operators[index])
            }
        }
    }

    // MARK: - Plus Operator

    func testGivenNoValueEntered_WhenAddingPlusOperator_ThenAddNewOperatorShouldReturnNil() {
        XCTAssertNil(calculator.addNewOperator(newOperator: .plus))
    }

    func testGivenOnePlusOne_WhenCalculatingTotal_ThenShouldBeTwo() {
        createCalc(numbers: [1, 1], operators: [.plus])

        XCTAssertEqual(calculator.calculateTotal(), 2)
    }

    func testGivenOneInputAndPlusOperator_WhenAddingPlusOperator_ThenAddNewOperatorShouldReturnFalse() {
        createCalc(numbers: [1], operators: [.plus])

        XCTAssertNil(calculator.addNewOperator(newOperator: .plus))
    }

    func testGiverOneInputAndPlusOperator_WhenAddingPlusOperator_ThenUpdateDisplayIsCorrect() {
        XCTAssertEqual(calculator.addNewNumber(1), "1")

        XCTAssertEqual(calculator.addNewOperator(newOperator: .plus), "1+")
    }

    // MARK: - Minus Operator

    func testGivenNoValueEntered_WhenAddingMinusOperator_ThenAddNewOperatorShouldReturnMinusString() {
        XCTAssertEqual(calculator.addNewOperator(newOperator: .minus), "-")
    }

    func testGivenMinusOnePlusOne_WhenCalculatingTotal_ThenShouldBeZero() {
        XCTAssertEqual(calculator.addNewOperator(newOperator: .minus), "-")
        createCalc(numbers: [1, 1], operators: [.plus])

        XCTAssertEqual(calculator.calculateTotal(), 0)
    }

    func testGivenTwoMinusOne_WhenCalculatingTotal_ThenShouldBeOne() {
        createCalc(numbers: [2, 1], operators: [.minus])

        XCTAssertEqual(calculator.calculateTotal(), 1)
    }

    func testGivenOneInputAndMinusOperator_WhenAddingMinusOperator_ThenAddNewOperatorShouldReturnFalse() {
        createCalc(numbers: [1], operators: [.minus])

        XCTAssertNil(calculator.addNewOperator(newOperator: .minus))
    }

    func testGivenOneInputAndMinusOperator_WhenAddingMinusOperator_ThenUpdateDisplayIsCorrect() {
        XCTAssertEqual(calculator.addNewNumber(1), "1")

        XCTAssertEqual(calculator.addNewOperator(newOperator: .minus), "1-")
    }

    // MARK: - Multiply Operator

    func testGivenNoValueEntered_WhenAddingMultiplyOperator_ThenAddNewOperatorShouldReturnNil() {
        XCTAssertNil(calculator.addNewOperator(newOperator: .multiply))
    }

    func testGivenThreeTimesThree_WhenCalculatingTotal_ThenShouldBeNine() {
        createCalc(numbers: [3, 3], operators: [.multiply])

        XCTAssertEqual(calculator.calculateTotal(), 9)
    }
    func testGivenCalculWithMultipleMultiplicationPriorities_WhenCalculatingTotal_ThenResultShouldBePriorityRelevant() {
        createCalc(numbers: [3, 4, 2, 1, 6], operators: [.plus, .multiply, .minus, .multiply])

        XCTAssertEqual(calculator.calculateTotal(), 5)
    }

    func testGivenOneInputAndMultiplyOperator_WhenAddingMultiplyOperator_ThenAddNewOperatorShouldReturnFalse() {
        createCalc(numbers: [1], operators: [.multiply])

        XCTAssertNil(calculator.addNewOperator(newOperator: .multiply))
    }

    func testGivenOneInputAndMultiplyOperator_WhenAddingMultiplyOperator_ThenUpdateDisplayIsCorrect() {
        XCTAssertEqual(calculator.addNewNumber(1), "1")

        XCTAssertEqual(calculator.addNewOperator(newOperator: .multiply), "1*")
    }

    // MARK: - Divide Operator

    func testGivenNoValueEntered_WhenAddingDivideOperator_ThenAddNewOperatorShouldReturnNil() {
        XCTAssertNil(calculator.addNewOperator(newOperator: .divide))
    }

    func testGivenSevenDividedByTwo_WhenCalculatingTotal_ThenShouldBeThreePointFive() {
        createCalc(numbers: [7, 2], operators: [.divide])

        XCTAssertEqual(calculator.calculateTotal(), 3.5)
    }
    func testGivenCalculWithMultipleDivisionPriorities_WhenCalculatingTotal_ThenResultShouldBePriorityRelevant() {
        createCalc(numbers: [3, 4, 2, 1, 6], operators: [.plus, .divide, .minus, .divide])
        //Round up
        XCTAssertEqual(calculator.calculateTotal(), 4.83)
    }

    func testGivenOneInputAndDivideOperator_WhenAddingDivideOperator_ThenAddNewOperatorShouldReturnFalse() {
        createCalc(numbers: [1], operators: [.divide])

        XCTAssertNil(calculator.addNewOperator(newOperator: .divide))
    }

    func testGivenOneInputAndDivideOperator_WhenAddingDivideOperator_ThenUpdateDisplayIsCorrect() {
        XCTAssertEqual(calculator.addNewNumber(1), "1")

        XCTAssertEqual(calculator.addNewOperator(newOperator: .divide), "1/")
    }

    func testGivenOneDividedByZero_WhenCalculatingTotal_ThenResultShouldBeNil() {
        createCalc(numbers: [1, 0], operators: [.divide])

        XCTAssertNil(calculator.calculateTotal())
    }

    func testGivenCalculWithMultipleDivisionPrioritiesWithZero_WhenCalculatingTotal_ThenResultShouldBeNil() {
        createCalc(numbers: [3, 4, 0, 1, 6], operators: [.plus, .divide, .minus, .divide])

        XCTAssertNil(calculator.calculateTotal())
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
