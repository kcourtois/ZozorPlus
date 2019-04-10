//
//  Calculator.swift
//  CountOnMe
//
//  Created by Kévin Courtois on 10/04/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

class Calculator {
    init() {

    }

    private func postNotification(message: String) {
        let name = Notification.Name(rawValue: NotificationStrings.didSendAlertNotificationName)
        NotificationCenter.default.post(name: name, object: nil,
                                        userInfo: [NotificationStrings.didSendAlertParameterKey: message])
    }
}
