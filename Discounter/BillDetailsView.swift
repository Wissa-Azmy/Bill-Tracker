//
//  CreateBillView.swift
//  Discounter
//
//  Created by Wissa Michael on 19.03.21.
//

import SwiftUI

struct BillDetailsView: View {
	let bill: Bill
	
	var body: some View {
		
			Form {
				Section(header: Text(Localization.AddBill.total)) {
					Text("\(Localization.AddBill.beforeSale) \(bill.totalPrice, specifier: "%.2f")")
					Text("\(Localization.AddBill.afterSale) \(bill.totalAfterSale, specifier: "%.2f")")
					Text("\(Localization.AddBill.youSave) \(bill.amountSaved, specifier: "%.2f")")
				}
				
				Section(header: VStack {
					HStack {
						Text("\(Localization.General.items) \(bill.items.count) \(Localization.AddBill.filteredByPeople)")
						Spacer()
					}
				}) {
					List {
						// We can discard the id: param since the items type conform to Identifiable protocol
						ForEach (bill.items) { item in
							HStack {
								Text("\(item.name) |")
								Text("$ \(item.price, specifier: "%.2f") |")
								Text("\(item.sale)% |")
								Text("$ \(item.discountedPrice, specifier: "%.2f") |")
							}
						}
						.onDelete(perform: { indexSet in

						})
					}
				}
			}
			.navigationBarTitle(bill.name)
		
	}
}

struct CreateBillView_Previews: PreviewProvider {
	static let bill = Bill(
		name: "Kaufland",
		totalPrice: 200,
		totalAfterSale: 150,
		amountSaved: 50,
		items: [PurchasedItem(name: "Rice", price: 1.5, numberOfPeople: 1, sale: 0, discountedPrice: 1.5)]
	)
	
    static var previews: some View {
		BillDetailsView(bill: bill)
    }
}
