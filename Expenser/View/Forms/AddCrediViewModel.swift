//
//  AddCrediViewModel.swift
//  Expenser
//
//  Created by Wissa.Michael on 11.02.23.
//

import Foundation
import Combine

final class AddCreditViewModel: ObservableObject {
    @Published var creditorName = ""
    @Published var creditAmount = ""
    @Published var interestRate = 0.0
    @Published var paymentAmount = ""
    @Published var remainingAmount = ""
    @Published var showingResetAlert = false

    @Published var payments = [Payment]()

    var originalAmount: String {
        String(format: "%.2f", Double(creditAmount) ?? 0.0)
    }

    var paidAmount: String {
        return String(format: "%.2f", Double(totalPaid))
    }

    var itemPriceAfterSale: Double {
        let price = Double(paymentAmount) ?? 0

        return (price - price / 100 * 5)
    }

    var isItemFormDisabled: Bool {
        paymentAmount.isEmpty || paymentAmount == " " || Int(paymentAmount) ?? 0 < 1
    }

    private var totalPaid: Double {
        payments.reduce(0) { $0 + $1.amount }
    }
    private var expensesStore: ExpensesDataStore
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization

    convenience init(credit: Credit? = nil) {
        self.init(expensesStore: ExpensesDataStore.shared, credit: credit)
    }

    init(expensesStore: ExpensesDataStore, credit: Credit?) {
        self.expensesStore = expensesStore

        bindPayments()
        bindCreditAmount()
        if let credit { updateForm(with: credit) }
    }

    func resetFormFields() {
        paymentAmount = ""
    }

    func addPayment() {
        let payment = Payment(amount: Double(paymentAmount) ?? 0, date: Date())

        payments.append(payment)
    }

    func addCreditor() {
        let creditor = Credit(
            name: creditorName,
            amount: Double(creditAmount) ?? 0,
            interestRate: Double(interestRate),
            payments: payments,
            date: Date()
        )

        expensesStore.credits.append(creditor)
    }

    private func updateForm(with credit: Credit) {
        creditorName = credit.name
        creditAmount = credit.amount.toString
        remainingAmount = credit.remainingAmount.toString
        interestRate = credit.interestRate
        payments = credit.payments
    }

    private func bindCreditAmount() {
        $creditAmount.sink(receiveValue: updateRemainingAmount).store(in: &cancellables)
    }

    private func bindPayments() {
        $payments.sink {
            let amount = Double(self.creditAmount) ?? 0.0
            let paid = $0.reduce(0) { $0 + $1.amount }
            let remaining = amount - paid

            self.remainingAmount = String(format: "%.2f", remaining)
        }.store(in: &cancellables)
    }

    private func updateRemainingAmount(_ value: String) {
        let netAmount = Double(creditAmount) ?? 0.0 - payments.reduce(0) { $0 + $1.amount }

        remainingAmount = String(format: "%.2f", netAmount)
    }
}
