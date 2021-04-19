//
//  ContentView.swift
//  Discounter
//
//  Created by Wissa Michael on 20.11.20.
//

import SwiftUI

struct AddBillView: View {
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var expenses: Expenses
	
	@State private var billName = ""
	@State private var itemName = ""
	@State private var itemPrice = ""
	@State private var saleValueIndex = 0
	@State private var numberOfPeople = 1
	@State private var showingResetAlert = false
	
	private let saleValues = [0, 10, 20, 30, 50, 70]
	
	@State private var totalPrice = 0.0
	@State private var totalAfterSale = 0.0
	@State private var amountSaved = 0.0
	
	@State private var items = [PurchasedItem]()
	@State private var filterValueIndex = 0
	@State private var filterValues = [Int]()
	
	var saleSavingsPerItem: Double {
		return (Double(itemPrice) ?? 0) / 100 * Double(saleValues[saleValueIndex])
	}
	
	var itemPriceAfterSale: Double {
		let price = Double(itemPrice) ?? 0
		let saleValue = Double(saleValues[saleValueIndex])
		
		return (price - price / 100 * saleValue)
	}
	
	private var isItemFormDisabled: Bool {
		itemPrice.isEmpty || itemPrice == " "
	}
	
	fileprivate func resetFormFields() {
		itemName = ""
		itemPrice = ""
		numberOfPeople = 1
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
		amountSaved += saleSavingsPerItem
		if !filterValues.contains(numberOfPeople) {
			filterValues.append(numberOfPeople)
			filterValues.sort()
		}
		
		var item = PurchasedItem()
		if !itemName.isEmpty {
			item.name = itemName
		} else {
			item.name = "\(Localization.AddBill.item) " + String(items.count + 1)
		}
		
		item.price = Double(itemPrice) ?? 0
		item.numberOfPeople = numberOfPeople
		item.sale = saleValues[saleValueIndex]
		item.discountedPrice = itemPriceAfterSale
		
		items.append(item)
	}
	
	var body: some View {
		NavigationView {
			Form {
				// Bill Name Field
				Section {
					TextField(Localization.AddBill.name, text: $billName)
				}
				// MARK: - Item fields FORM
				Section(header: Text(Localization.AddBill.itemDetails)) {
					VStack {
						HStack {
							Text(Localization.AddBill.saleValue).font(.footnote)
							Spacer()
						}
						Picker(Localization.AddBill.sale, selection: $saleValueIndex) {
							ForEach(saleValues.indices) {
								Text("\(saleValues[$0])%")
							}
						}
						.pickerStyle(SegmentedPickerStyle())
					}
				
					HStack{
						TextField(Localization.AddBill.itemName, text: $itemName)
						Text("💲")
						TextField(Localization.AddBill.price, text: $itemPrice)
							.keyboardType(.decimalPad)
					}
					Stepper(value: $numberOfPeople, in: 1...10) {
						Text("\(Localization.AddBill.people) \(numberOfPeople)")
					}
					HStack {
						Text("\(Localization.AddBill.salePrice) \(itemPriceAfterSale, specifier: "%.2f")")
						Spacer()
						Button(Localization.AddBill.add) {
							addItem()
							resetFormFields()
						}
						.disabled(isItemFormDisabled)
					}
				}
				// Stats View
				Section(header: Text(Localization.AddBill.total)) {
					Text("\(Localization.AddBill.beforeSale) \(totalPrice, specifier: "%.2f")")
					Text("\(Localization.AddBill.afterSale) \(totalAfterSale, specifier: "%.2f")")
					Text("\(Localization.AddBill.youSave) \(amountSaved, specifier: "%.2f")")
				}
				// Filter items
				Section(header: VStack {
					HStack {
						Text("\(Localization.General.items) \(items.count) \(Localization.AddBill.filteredByPeople)")
						Spacer()
						Button(action: {
							showingResetAlert = true
						}, label: {
							Text(Localization.AddBill.reset)
						})
						.alert(isPresented: $showingResetAlert) {
							Alert(
								title: Text(Localization.AddBill.careful),
								message: Text(Localization.AddBill.deleteAllItems),
								primaryButton: .default(Text("OK")){
									resetBillData()
								},
								secondaryButton: .cancel()
							)
						}
					}
					if filterValues.count > 1 {
						Picker(Localization.AddBill.filter, selection: $filterValueIndex) {
							ForEach(filterValues.indices, id: \.self) {
								Text("\(filterValues[$0])")
							}
						}
						.pickerStyle(SegmentedPickerStyle())
					}
				}) {
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
			.navigationTitle(Localization.AddBill.addBill)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AddBillView(expenses: Expenses())
    }
}
