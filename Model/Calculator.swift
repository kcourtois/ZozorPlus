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

    var isExpressionCorrect: Bool {
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

    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last, stringNumber.isEmpty {
            postNotification(message: "Expression incorrecte !")
            return false
        }
        return true
    }

    private var needPriorities: Bool {
        var count = 0
        for ope in operators where ope == .multiply {
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

    func calculateTotal() -> Int? {
        if !isExpressionCorrect {
            return nil
        }

        if needPriorities {
            print("abcdef")
            calculatePriorities()
        }

        var total = 0

        for (index, stringNumber) in stringNumbers.enumerated() {
            if let number = Int(stringNumber) {
                if operators[index] == .plus {
                    total += number
                } else if operators[index] == .minus {
                    total -= number
                } else if operators[index] == .multiply {
                    total *= number
                }
            }
        }

        clear()

        return total
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
    private func calculatePriorities() {
        //Loop through operators to find mulitply
        for (index, ope) in operators.enumerated() where ope == .multiply {
            //define indexes for numbers that are needed in operation
            let firstIndex = index-1
            let secondIndex = index
            //Check if the indexes are valid
            if stringNumbers.indices.contains(firstIndex) && stringNumbers.indices.contains(secondIndex) {
                //Get the numbers from indexes
                if let firstNum = Int(stringNumbers[firstIndex]), let secondNum = Int(stringNumbers[secondIndex]) {
                    //Do the operation
                    let totalMult = firstNum * secondNum
                    //Remove one number and put the result in place of the old one
                    stringNumbers[firstIndex] = "\(totalMult)"
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
            calculatePriorities()
        }
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
