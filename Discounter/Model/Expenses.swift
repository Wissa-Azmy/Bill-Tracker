//
//  Expenses.swift
//  Discounter
//
//  Created by Wissa Michael on 19.03.21.
//

import Foundation

class Expenses: ObservableObject {
	@Published var bills = [Bill]()
}


struct Bill {
	let name: String
	let items: [PurchasedItem]
}


struct PurchasedItem {
	let id = UUID()
	var name = ""
	var price = 0.0
	var numberOfPeople = 0
	var sale = 0
	var discountedPrice = 0.0
}
