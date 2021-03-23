//
//  DebtorsListView.swift
//  Discounter
//
//  Created by Wissa Michael on 22.03.21.
//

import SwiftUI

struct DebtorsListView: View {
	@Binding var debtors: [Debtor]
	
	var body: some View {
		List {
			ForEach(debtors) { debtor in
				NavigationLink(destination: Text("Creditor Details")) {
					VStack {
						HStack {
							Text(debtor.name)
								.font(.headline)
							Spacer()
							Text("Original Amount: \(debtor.amount, specifier: "%.2f")")
						}
						HStack {
							Text("Payments count: \(debtor.payments.count)")
							Spacer()
							if debtor.payments.count > 0 {
								Text("Remaining Amount: \(debtor.remainingAmount, specifier: "%.2f")")
							}
						}
					}
				}
			}
		}
	}
}

struct DebtorsList_Previews: PreviewProvider {
    static var previews: some View {
		DebtorsListView(debtors: .constant([Debtor]()))
    }
}
