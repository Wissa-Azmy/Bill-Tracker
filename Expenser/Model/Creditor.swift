//
//  Creditor.swift
//  Discounter
//
//  Created by Wissa Michael on 18.04.21.
//

import Foundation
import FirebaseFirestoreSwift

struct Creditor: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    let name: String
    let amount: Double
    let interestRate: Double
    let payments: [Payment]
    let date: Date

    var paid: Double {
        payments.reduce(0) { $0 + $1.amount }
    }

    var remainingAmount: Double {
        amount - paid
    }

    static func == (lhs: Creditor, rhs: Creditor) -> Bool {
        lhs.name == rhs.name
    }
}
