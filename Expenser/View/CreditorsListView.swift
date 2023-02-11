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
                ForEach(creditors, id: \.self) { credit in
					NavigationLink(destination: Text("Creditor Details")) {
                        CreditItemCard(credit: credit)
					}
				}
                .onDelete { indexSet in
                    creditors.remove(atOffsets: indexSet)
                }
			}
		} else {
			PlaceholderImage(name: "wallet")
		}
    }
}

struct CreditorsList_Previews: PreviewProvider {
    static var previews: some View {
		CreditorsListView(creditors: .constant([Creditor]()))
    }
}

struct CreditItemCard: View {
    let credit: Creditor

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(credit.name)
                    .font(.headline)

                HStack {
                    VStack(alignment: .leading) {
                        Text("Amount: ")
                        Text("Paid: ")
                        if credit.payments.count > 0 {
                            Text("Remaining: ")
                        }
                    }

                    Spacer()

                    VStack(alignment: .leading) {
                        Text("\(credit.amount, specifier: "%.2f")")
                        Text("\(credit.paid, specifier: "%.2f")")
                        if credit.payments.count > 0 {
                            Text("\(credit.remainingAmount, specifier: "%.2f")")
                        }
                    }
                }
            }

            Spacer()
        }
    }
}

struct CreditItemCard_Previews: PreviewProvider {
    static let credit = Creditor(
        name: "Item",
        amount: 200,
        interestRate: 0,
        payments: [],
        date: Date()
    )

    static var previews: some View {
        CreditItemCard(credit: credit)
            .padding()
    }
}
