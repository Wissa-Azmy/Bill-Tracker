//
//  Bill.swift
//  Discounter
//
//  Created by Wissa Michael on 18.04.21.
//

import Foundation
import FirebaseFirestoreSwift

struct Bill: Identifiable, Codable {
	@DocumentID var id: String?
	let date = Date()
	let name: String
	let totalPrice: Double
	let totalAfterSale: Double
	let amountSaved: Double
	let items: [PurchasedItem]
	
	var createdAtDate: String {
		let formatter = DateFormatter()
		formatter.dateStyle = .long
		return formatter.string(from: date)
	}
}
