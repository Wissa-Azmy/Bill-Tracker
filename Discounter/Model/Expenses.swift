//
//  Expenses.swift
//  Discounter
//
//  Created by Wissa Michael on 19.03.21.
//

import Foundation

class Expenses: ObservableObject {
	@Published var bills = [Bill]() {
		didSet {
			let encoder = JSONEncoder()
			if let billsData = try? encoder.encode(bills) {
				UserDefaults.standard.setValue(billsData, forKey: "Bills")
			}
		}
	}
	
	init() {
		if let billsData = UserDefaults.standard.data(forKey: "Bills") {
			let decoder = JSONDecoder()
			if let decodedBills = try? decoder.decode([Bill].self, from: billsData) {
				bills = decodedBills
				return
			}
		}
		
		bills = []
	}
}


struct Bill: Identifiable, Codable {
	var id = UUID()
	let name: String
	let totalPrice: Double
	let totalAfterSale: Double
	let amountSaved: Double
	let items: [PurchasedItem]
}


struct PurchasedItem: Identifiable, Codable {
	var id = UUID()
	var name = ""
	var price = 0.0
	var numberOfPeople = 0
	var sale = 0
	var discountedPrice = 0.0
}
