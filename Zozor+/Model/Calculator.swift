//
//  Calculator.swift
//  CountOnMe
//
//  Created by Kévin Courtois on 10/04/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

class Calculator {

    // MARK: - Properties

    private var stringNumbers: [String] = [String()]
    private var operators: [Operator] = [.plus]
    private var index = 0

    private var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last, stringNumber.isEmpty {
            if stringNumbers.count == 1 {
                postNotification(message: "Démarrez un nouveau calcul !")
            } else {
                postNotification(message: "Entrez une expression correcte !")
            }
            return false
        }
        return true
    }

    private var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last, stringNumber.isEmpty {
            postNotification(message: "Expression incorrecte !")
            return false
        }
        return true
    }

    private var needPriorities: Bool {
        var count = 0
        for ope in operators where ope == .multiply || ope == .divide {
            count += 1
        }
        return count > 0
    }

    // MARK: - Methods

    func addNewNumber(_ newNumber: Int) -> String? {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
            return updateDisplay()
        }
        return nil
    }

    func addNewOperator(newOperator: Operator) -> String? {
        if canAddOperator {
            operators.append(newOperator)
            stringNumbers.append("")
            return updateDisplay()
        }
        return nil
    }

    func calculateTotal() -> Double? {
        if !isExpressionCorrect {
            return nil
        }

        if !calculatePriorities() {
            clear()
            return nil
        }

        var total = 0.0

        for (index, stringNumber) in stringNumbers.enumerated() {
            if let number = Double(stringNumber) {
                if operators[index] == .plus {
                    total += number
                } else if operators[index] == .minus {
                    total -= number
                }
            }
        }

        clear()

        //returns decimal value with two digits
        return round(total * 100) / 100
    }

    private func updateDisplay() -> String {
        var text = ""
        for (index, stringNumber) in stringNumbers.enumerated() {
            // Add operator
            if index > 0 {
                text += operators[index].rawValue
            }
            // Add number
            text += stringNumber
        }
        return text
    }

    //Handles multiplication priorities and replace them by the result.
    private func calculatePriorities() -> Bool {
        //Loop through operators to find mulitply
        for (index, ope) in operators.enumerated() where ope == .multiply || ope == .divide {
            //define indexes for numbers that are needed in operation
            let firstIndex = index-1
            let secondIndex = index
            //Check if the indexes are valid
            if stringNumbers.indices.contains(firstIndex) && stringNumbers.indices.contains(secondIndex) {
                //Get the numbers from indexes
                if let firstNum = Double(stringNumbers[firstIndex]),
                    let secondNum = Double(stringNumbers[secondIndex]) {
                    var totalCalc = 0.0
                    //Do the operation
                    if ope == .multiply {
                        totalCalc = firstNum * secondNum
                    } else if ope == .divide {
                        if secondNum == 0 {
                            return false
                        } else {
                            totalCalc = firstNum / secondNum
                        }
                    }
                    //Remove one number and put the result in place of the old one
                    stringNumbers[firstIndex] = "\(totalCalc)"
                    stringNumbers.remove(at: secondIndex)
                    //Remove operator
                    operators.remove(at: index)
                    //Quit loop
                    break
                }
            }
        }

        //If there are still priorities to apply, calls itself
        if needPriorities {
            return calculatePriorities()
        }

        return true
    }

    private func clear() {
        stringNumbers = [String()]
        operators = [.plus]
        index = 0
    }

    private func postNotification(message: String) {
        let name = Notification.Name(rawValue: NotificationStrings.didSendAlertNotificationName)
        NotificationCenter.default.post(name: name, object: nil,
                                        userInfo: [NotificationStrings.didSendAlertParameterKey: message])
    }
}
