//
//  ContentView.swift
//  Discounter
//
//  Created by Wissa Michael on 20.11.20.
//

import SwiftUI

struct Item {
	let id = UUID()
	var name = ""
	var price = 0.0
	var numberOfPeople = 0
	var sale = 0
	var discountedPrice = 0.0
}

struct ContentView: View {
	@State private var itemName = ""
	@State private var itemPrice = ""
	@State private var saleValueIndex = 0
	@State private var numberOfPeople = 1
	@State private var showingResetAlert = false
	
	private let saleValues = [0, 10, 20, 30, 50, 70]
	
	@State private var totalPrice = 0.0
	@State private var totalAfterSale = 0.0
	@State private var totalSaved = 0.0
	
	@State private var items = [Item]()
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
	
	fileprivate func resetItemData() {
		itemName = ""
		itemPrice = ""
		numberOfPeople = 1
	}
	
	fileprivate func resetBillData() {
		items.removeAll()
		filterValues = []
		totalPrice = 0.0
		totalAfterSale = 0.0
		totalSaved = 0.0
	}
	
	fileprivate func addItem() {
		guard !itemPrice.isEmpty && itemPrice != " " else { return }
		
		totalPrice += Double(itemPrice) ?? 0
		totalAfterSale += itemPriceAfterSale
		totalSaved += saleSavingsPerItem
		if !filterValues.contains(numberOfPeople) {
			filterValues.append(numberOfPeople)
			filterValues.sort()
		}
		print(filterValues.count)
		
		
		var item = Item()
		if !itemName.isEmpty {
			item.name = itemName
		} else {
			item.name = "Item " + String(items.count + 1)
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
				Section(header: Text("Pick Sale Value")) {
					Picker("Sale", selection: $saleValueIndex) {
						ForEach(saleValues.indices) {
							Text("\(saleValues[$0])%")
						}
					}
					.pickerStyle(SegmentedPickerStyle())
				}
				
				Section {
					HStack{
						TextField("Item name", text: $itemName)
						Text("💲")
						TextField("Amount", text: $itemPrice)
							.keyboardType(.decimalPad)
					}
					Stepper(value: $numberOfPeople, in: 1...10) {
						Text("People: \(numberOfPeople)")
					}
					HStack {
						Text("Sale Price: $ \(itemPriceAfterSale, specifier: "%.2f")")
						Spacer()
						Button("Add ➕") {
							addItem()
							resetItemData()
						}
					}
				}
				
				Section(header: Text("Total")) {
					Text("Before Sale: $ \(totalPrice, specifier: "%.2f")")
					Text("After Sale: $ \(totalAfterSale, specifier: "%.2f")")
					Text("You Save: $ \(totalSaved, specifier: "%.2f")")
				}
				
				Section(header: VStack {
					HStack {
						Text("Items: \(items.count) (filtered by no. of people)")
						Spacer()
						Button(action: {
							showingResetAlert = true
						}, label: {
							Text("Reset")
						})
						.alert(isPresented: $showingResetAlert) {
							Alert(
								title: Text("Careful!"),
								message: Text("This will delete all your items"),
								primaryButton: .default(Text("OK")){
									resetBillData()
								},
								secondaryButton: .cancel()
							)
						}
					}
					if filterValues.count > 1 {
						Picker("Filter", selection: $filterValueIndex) {
							ForEach(filterValues.indices, id: \.self) {
								Text("\(filterValues[$0])")
							}
						}
						.pickerStyle(SegmentedPickerStyle())
					}
				}) {
					List {
						ForEach (items, id: \.id) { item in
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
			.navigationTitle("Bill Name")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
