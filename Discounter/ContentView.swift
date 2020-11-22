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
	var sale = 0
	var discountedPrice = 0.0
}

struct ContentView: View {
	@State private var itemName = ""
	@State private var itemPrice = ""
	@State private var saleValueIndex = 0
	private var saleValues = [0, 10, 20, 30, 50, 70]
	
	@State private var totalPrice = 0.0
	@State private var totalAfterSale = 0.0
	@State private var totalSaved = 0.0
	
	@State private var items = [Item]()
	
	var saleSavingsPerItem: Double {
		return (Double(itemPrice) ?? 0) / 100 * Double(saleValues[saleValueIndex])
	}
	
	var itemPriceAfterSale: Double {
		let price = Double(itemPrice) ?? 0
		let saleValue = Double(saleValues[saleValueIndex])
		
		return (price - price / 100 * saleValue)
	}
	
	var body: some View {
		NavigationView {
			Form {
				Section(header: Text("Pick Sale Value")) {
					Picker("Tip", selection: $saleValueIndex) {
						ForEach(0 ..< saleValues.count) {
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
					HStack {
						Text("Sale Price: $ \(itemPriceAfterSale, specifier: "%.2f")")
						Spacer()
						Button("Add ➕") {
							guard !itemPrice.isEmpty && itemPrice != " " else { return }
							
							totalPrice += Double(itemPrice) ?? 0
							totalAfterSale += itemPriceAfterSale
							totalSaved += saleSavingsPerItem
							
							var item = Item()
							if !itemName.isEmpty {
								item.name = itemName
							} else {
								item.name = "Item " + String(items.count + 1)
							}
							
							item.price = Double(itemPrice) ?? 0
							item.sale = saleValues[saleValueIndex]
							item.discountedPrice = itemPriceAfterSale
							
							itemName = ""
							itemPrice = ""
							
							items.append(item)
						}
					}
				}
				
				Section(header: Text("Total")) {
					Text("Before Sale: $ \(totalPrice, specifier: "%.2f")")
					Text("After Sale: $ \(totalAfterSale, specifier: "%.2f")")
					Text("You Save: $ \(totalSaved, specifier: "%.2f")")
				}
				
				Section(header: HStack {
					Text("Items: \(items.count)")
					Spacer()
					Button(action: {
						items.removeAll()
						totalPrice = 0.0
						totalAfterSale = 0.0
						totalSaved = 0.0
					}, label: {
						Text("Reset")
					})
				}) {
					List(items, id: \.id) { item in
						
						HStack {
							Text("\(item.name) |")
							Text("$ \(item.price, specifier: "%.2f") |")
							Text("\(item.sale)% |")
							Text("$ \(item.discountedPrice, specifier: "%.2f") |")
						}
					}
				}
			}
			.navigationTitle("Discounter")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
