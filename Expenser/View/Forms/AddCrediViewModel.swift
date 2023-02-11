//
//  AddCrediViewModel.swift
//  Expenser
//
//  Created by Wissa.Michael on 11.02.23.
//

import Foundation

final class AddCreditViewModel: ObservableObject {
    @Published var creditorName = ""
    @Published var creditAmount = ""
    @Published var interestRate = 0
    @Published var paymentAmount = ""
    @Published var showingResetAlert = false

    @Published var originalAmount = 0.0
    @Published var paidAmount = 0.0
    @Published var remainingAmount = 0.0

    @Published var payments = [Payment]()

    var itemPriceAfterSale: Double {
        let price = Double(paymentAmount) ?? 0

        return (price - price / 100 * 5)
    }

    var isItemFormDisabled: Bool {
        paymentAmount.isEmpty || paymentAmount == " " || Int(paymentAmount) ?? 0 < 1
    }

    var expensesStore: Expenses

    convenience init() {
        self.init(expensesStore: Expenses.shared)
    }

    init(expensesStore: Expenses) {
        self.expensesStore = expensesStore
    }

    func resetFormFields() {
        paymentAmount = ""
    }

    func addPayment() {
        let payment = Payment(amount: Double(paymentAmount) ?? 0, date: Date())

        payments.append(payment)
    }

    func addCreditor() {
        let creditor = Creditor(
            name: creditorName,
            amount: Double(creditAmount) ?? 0,
            interestRate: Double(interestRate),
            payments: payments
        )

        expensesStore.creditors.append(creditor)
    }
}
