//
//  CreditorsListView.swift
//  Discounter
//
//  Created by Wissa Michael on 22.03.21.
//

import SwiftUI

struct CreditorsListView: View {
	@Binding var creditors: [Creditor]
	
    var body: some View {
		if !creditors.isEmpty {
			List {
				ForEach(creditors) { creditor in
					NavigationLink(destination: Text("Creditor Details")) {
						VStack {
							HStack {
								Text(creditor.name)
									.font(.headline)
								Spacer()
								Text("Original Amount: \(creditor.amount, specifier: "%.2f")")
							}
							HStack {
								Text("Payments count: \(creditor.payments.count)")
								Spacer()
								if creditor.payments.count > 0 {
									Text("Remaining Amount: \(creditor.remainingAmount, specifier: "%.2f")")
								}
							}
						}
					}
				}
				.onDelete(perform: { indexSet in
					creditors.remove(atOffsets: indexSet)
				})
			}
		} else {
			VStack{
				Spacer()
				Image("wallet")
					.resizable()
					.scaledToFit()
				Spacer()
			}
		}
    }
}

struct CreditorsList_Previews: PreviewProvider {
    static var previews: some View {
		CreditorsListView(creditors: .constant([Creditor]()))
    }
}
