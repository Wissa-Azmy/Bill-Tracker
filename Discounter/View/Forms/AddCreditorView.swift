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
	
	@State private var billName = ""
	@State private var itemName = ""
	@State private var itemPrice = ""
	@State private var interestRate = 0
	@State private var showingResetAlert = false
	
	@State private var totalPrice = 0.0
	@State private var totalAfterSale = 0.0
	@State private var amountSaved = 0.0
	
	@State private var items = [PurchasedItem]()
	@State private var filterValueIndex = 0
	@State private var filterValues = [Int]()
	
	var itemPriceAfterSale: Double {
		let price = Double(itemPrice) ?? 0
		
		return (price - price / 100 * 5)
	}
	
	private var isItemFormDisabled: Bool {
		itemPrice.isEmpty || itemPrice == " "
	}
	
	fileprivate func resetFormFields() {
		itemName = ""
		itemPrice = ""
		interestRate = 1
	}
	
	fileprivate func resetBillData() {
		items.removeAll()
		filterValues = []
		totalPrice = 0.0
		totalAfterSale = 0.0
		amountSaved = 0.0
	}
	
	fileprivate func addItem() {
		totalPrice += Double(itemPrice) ?? 0
		totalAfterSale += itemPriceAfterSale
		if !filterValues.contains(interestRate) {
			filterValues.append(interestRate)
			filterValues.sort()
		}
		
		var item = PurchasedItem()
		if !itemName.isEmpty {
			item.name = itemName
		} else {
			item.name = "\(Localization.AddBill.item) " + String(items.count + 1)
		}
		
		item.price = Double(itemPrice) ?? 0
		item.numberOfPeople = interestRate
		item.discountedPrice = itemPriceAfterSale
		
		items.append(item)
	}
	
	var body: some View {
		NavigationView {
			Form {
				// MARK: - Item fields FORM
				Section {
					HStack{
						TextField("Creditor Name", text: $itemName)
						Text("💲")
						TextField("Amount", text: $itemPrice)
							.keyboardType(.decimalPad)
					}
					
					Stepper(value: $interestRate, in: 0...15) {
						Text("Interest: \(interestRate) %")
					}
					
					Button(Localization.AddBill.add) {
						addItem()
						resetFormFields()
					}
					.disabled(isItemFormDisabled)
					
				}
				// Stats View
				Section(header: Text(Localization.AddBill.total)) {
					Text("\(Localization.AddBill.beforeSale) \(totalPrice, specifier: "%.2f")")
					Text("\(Localization.AddBill.afterSale) \(totalAfterSale, specifier: "%.2f")")
					Text("\(Localization.AddBill.youSave) \(amountSaved, specifier: "%.2f")")
				}
				// Filter items
				Section(header: Text("Items")) {
					// MARK: - List of Items
					List {
						// We can discard the id: param since the items type conform to Identifiable protocol
						ForEach (items) { item in
							HStack {
								Text("\(item.name) |")
								Text("$ \(item.price, specifier: "%.2f") |")
								Text("\(item.sale)% |")
								Text("$ \(item.discountedPrice, specifier: "%.2f") |")
							}
						}
						.onDelete(perform: { indexSet in
							items.remove(atOffsets: indexSet)
						})
					}
				}
			}
			.navigationTitle("Add New Creditor")
			.navigationBarItems(trailing: Button(Localization.General.save) {
				let bill = Bill(
					name: billName,
					totalPrice: totalPrice,
					totalAfterSale: totalAfterSale,
					amountSaved: amountSaved,
					items: items
				)
				expenses.bills.append(bill)
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
