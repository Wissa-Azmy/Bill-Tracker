//
//  AddCreditorView.swift
//  Discounter
//
//  Created by Wissa Michael on 22.03.21.
//

import SwiftUI

struct AddCreditorView: View {
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var expenses: Expenses
	
	@State private var creditorName = ""
	@State private var creditAmount = ""
	@State private var interestRate = 0
	@State private var paymentAmount = ""
	@State private var showingResetAlert = false
	
	@State private var originalAmount = 0.0
	@State private var paidAmount = 0.0
	@State private var remainingAmount = 0.0
	
	@State private var payments = [Payment]()
	
	var itemPriceAfterSale: Double {
		let price = Double(paymentAmount) ?? 0
		
		return (price - price / 100 * 5)
	}
	
	private var isItemFormDisabled: Bool {
		paymentAmount.isEmpty || paymentAmount == " " || Int(paymentAmount) ?? 0 < 1
	}
	
	fileprivate func resetFormFields() {
		paymentAmount = ""
	}
	
	fileprivate func addPayment() {
		let payment = Payment(amount: Double(paymentAmount) ?? 0)
		
		payments.append(payment)
	}
	
	var body: some View {
		NavigationView {
			Form {
				// MARK: - Item fields FORM
				Section {
					HStack{
						TextField("Creditor Name", text: $creditorName)
						Text("💲")
						TextField("Credit Amount", text: $creditAmount)
							.keyboardType(.decimalPad)
					}
					
					Stepper(value: $interestRate, in: 0...15) {
						Text("Interest: \(interestRate) %")
					}
				}
				
				Section(header: Text("Record payments for this creditor")) {
					HStack {
						TextField("Amount", text: $paymentAmount)
							.keyboardType(.decimalPad)
						Button(Localization.AddBill.add) {
							addPayment()
							resetFormFields()
						}
						.disabled(isItemFormDisabled)
					}
				}
				
				// Stats View
				Section(header: Text("Stats")) {
					Text("Original Amount: \(originalAmount, specifier: "%.2f")")
					Text("Paid: \(paidAmount, specifier: "%.2f")")
					Text("Remaining: \(remainingAmount, specifier: "%.2f")")
				}
				// Filter items
				Section(header: Text("Payments: \(payments.count)")) {
					// MARK: - List of Items
					List {
						// We can discard the id: param since the items type conform to Identifiable protocol
						ForEach (payments) { payment in
							HStack {
								Text("$ \(payment.amount, specifier: "%.2f") |")
								Text("\(payment.date)% |")
							}
						}
						.onDelete(perform: { indexSet in
							payments.remove(atOffsets: indexSet)
						})
					}
				}
			}
			.navigationTitle("Add New Creditor")
			.navigationBarItems(trailing: Button(Localization.General.save) {
				let creditor = Creditor(
					name: creditorName,
					amount: Double(creditAmount) ?? 0,
					interestRate: Double(interestRate),
					payments: payments
				)
				
				expenses.creditors.append(creditor)
				presentationMode.wrappedValue.dismiss()
			})
		}
	}
}

struct AddCreditorView_Previews: PreviewProvider {
    static var previews: some View {
        AddCreditorView(expenses: Expenses())
    }
}
