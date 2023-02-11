//
//  AddCreditorView.swift
//  Discounter
//
//  Created by Wissa Michael on 22.03.21.
//

import SwiftUI

struct AddCreditorView: View {
	@Environment(\.presentationMode) var presentationMode

    @ObservedObject var viewModel: AddCreditViewModel
	
	var body: some View {
		NavigationView {
			Form {
				// MARK: - Item fields FORM
				Section {
					HStack{
                        TextField("Creditor Name", text: $viewModel.creditorName)
						Text("💲")
                        TextField("Credit Amount", text: $viewModel.creditAmount)
							.keyboardType(.decimalPad)
					}
					
                    Stepper(value: $viewModel.interestRate, in: 0...15) {
                        Text("Interest: \(viewModel.interestRate) %")
					}
				}
				
				Section(header: Text("Record payments for this creditor")) {
					HStack {
                        TextField("Amount", text: $viewModel.paymentAmount)
							.keyboardType(.decimalPad)
						Button(Localization.AddBill.add) {
                            viewModel.addPayment()
                            viewModel.resetFormFields()
						}
                        .disabled(viewModel.isItemFormDisabled)
					}
				}
				
				// Stats View
				Section(header: Text("Stats")) {
                    Text("Original Amount: \(viewModel.originalAmount, specifier: "%.2f")")
                    Text("Paid: \(viewModel.paidAmount, specifier: "%.2f")")
                    Text("Remaining: \(viewModel.remainingAmount, specifier: "%.2f")")
				}
				// Filter items
                Section(header: Text("Payments: \(viewModel.payments.count)")) {
					// MARK: - List of Items
					List {
                        ForEach (viewModel.payments) { payment in
							HStack {
								Text("$ \(payment.amount, specifier: "%.2f") |")
								Text("\(payment.date)% |")
							}
						}
						.onDelete(perform: { indexSet in
                            viewModel.payments.remove(atOffsets: indexSet)
						})
					}
				}
			}
			.navigationTitle("Add New Creditor")
			.navigationBarItems(trailing: Button(Localization.General.save) {
                viewModel.addCreditor()
                
				presentationMode.wrappedValue.dismiss()
			})
		}
	}
}

struct AddCreditorView_Previews: PreviewProvider {
    static var previews: some View {
        AddCreditorView(viewModel: AddCreditViewModel())
    }
}