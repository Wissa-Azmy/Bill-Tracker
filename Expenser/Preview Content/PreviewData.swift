//
//  PreviewData.swift
//  Expenser
//
//  Created by Wissa.Michael on 16.02.23.
//

import Foundation

struct PreviewData {
    static let credit = Credit(
        name: "Some Creditor",
        amount: 200,
        interestRate: 0,
        payments: [Payment(amount: 100, date: Date())],
        date: Date()
    )
}
