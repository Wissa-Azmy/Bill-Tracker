//
//  Debtor.swift
//  Discounter
//
//  Created by Wissa Michael on 18.04.21.
//

import Foundation
import FirebaseFirestoreSwift

struct Debtor: Identifiable, Codable {
	@DocumentID var id: String?
	let date = Date()
	let name: String
	let amount: Double
	let interestRate: Double
	let payments: [Payment]
	
	var remainingAmount: Double {
		amount - payments.reduce(0) { $0 + $1.amount }
	}
}
