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
			saveDataOf(bills, forKey: "Bills")
		}
	}
	
	@Published var creditors = [Creditor]() {
		didSet {
			saveDataOf(creditors, forKey: "Creditors")
		}
	}
	
	@Published var debtors = [Debtor]() {
		didSet {
			saveDataOf(debtors, forKey: "Debtors")
		}
	}
	
	init() {
		bills = loadDataFor(key: "Bills") ?? []
		creditors = loadDataFor(key: "Creditors") ?? []
		debtors = loadDataFor(key: "Debtors") ?? []
	}
	
	// MARK: - Coding & Loading Data
	private func loadDataFor<T: Codable>(key: String) -> T? {
		if let data = UserDefaults.standard.data(forKey: key) {
			let decoder = JSONDecoder()
			if let decodedItems = try? decoder.decode(T.self, from: data) {
				return decodedItems
			}
		}
		
		return nil
	}
	
	private func saveDataOf<T: Codable>(_ data: T, forKey key: String) {
		if let encodedData = try? JSONEncoder().encode(data) {
			UserDefaults.standard.setValue(encodedData, forKey: key)
		}
	}
}

struct Debtor: Identifiable, Codable {
	let id = UUID()
	let date = Date()
	let name: String
	let amount: Double
	let interestRate: Double
	let payments: [Payment]
	
	var remainingAmount: Double {
		amount - payments.reduce(0) { $0 + $1.amount }
	}
}

struct Creditor: Identifiable, Codable {
	let id = UUID()
	let date = Date()
	let name: String
	let amount: Double
	let interestRate: Double
	let payments: [Payment]
	
	var remainingAmount: Double {
		amount - payments.reduce(0) { $0 + $1.amount }
	}
}

struct Payment: Identifiable, Codable {
	let id = UUID()
	let date = Date()
	let amount: Double
}

struct Bill: Identifiable, Codable {
	let id = UUID()
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


struct PurchasedItem: Identifiable, Codable {
	let id = UUID()
	var name = ""
	var price = 0.0
	var numberOfPeople = 0
	var sale = 0
	var discountedPrice = 0.0
}
