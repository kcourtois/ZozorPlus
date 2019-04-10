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
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count == 1 {
                    postNotification(message: "Démarrez un nouveau calcul !")
                } else {
                    postNotification(message: "Entrez une expression correcte !")
                }
                return false
            }
        }
        return true
    }

    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                postNotification(message: "Expression incorrecte !")
                return false
            }
        }
        return true
    }

    // MARK: - Methods

    func addNewNumber(_ newNumber: Int) -> Bool {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
            return true
        }
        return false
    }

    func addNewOperator(newOperator: Operator) -> Bool {
        if canAddOperator {
            operators.append(newOperator)
            stringNumbers.append("")
            return true
        }
        return false
    }

    func calculateTotal() -> Int? {
        if !isExpressionCorrect {
            return nil
        }

        var total = 0
        for (index, stringNumber) in stringNumbers.enumerated() {
            if let number = Int(stringNumber) {
                if operators[index] == .plus {
                    total += number
                } else if operators[index] == .minus {
                    total -= number
                }
            }
        }

        clear()

        return total
    }

    func updateDisplay() -> String {
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

    func clear() {
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
