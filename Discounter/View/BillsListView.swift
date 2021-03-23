//
//  BillsListView.swift
//  Discounter
//
//  Created by Wissa Michael on 22.03.21.
//

import SwiftUI

struct BillsListView: View {
	@Binding var bills: [Bill]
	
	var body: some View {
		List {
			ForEach(bills) { bill in
				NavigationLink(destination: BillDetailsView(bill: bill)) {
					VStack {
						HStack {
							Text(bill.name)
								.font(.headline)
							Spacer()
							Text("\(Localization.Home.paid) \(bill.totalAfterSale, specifier: "%.2f")")
						}
						HStack {
							Text("\(Localization.General.items) \(bill.items.count)")
							Spacer()
							if bill.amountSaved > 0 {
								Text("\(Localization.Home.saved) \(bill.amountSaved, specifier: "%.2f")")
							}
						}
					}
				}
			}
			.onDelete(perform: { indexSet in
				bills.remove(atOffsets: indexSet)
			})
		}
	}
}

struct BillsList_Previews: PreviewProvider {
    static var previews: some View {
		BillsListView(bills: .constant([Bill]()))
    }
}
