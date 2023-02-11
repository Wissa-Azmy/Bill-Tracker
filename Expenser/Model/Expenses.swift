//
//  Expenses.swift
//  Discounter
//
//  Created by Wissa Michael on 19.03.21.
//

import Foundation
import FirebaseFirestoreSwift

class Expenses: ObservableObject, Codable {
	@DocumentID var id: String?
	var userId: String?

    static let shared = Expenses()

	@Published var bills = [Bill]() {
		didSet {
			LocalDataSource.saveDataOf(bills, forKey: "Bills")
		}
	}
	
	@Published var creditors = [Creditor]() {
		didSet {
			LocalDataSource.saveDataOf(creditors, forKey: "Creditors")
		}
	}
	
	@Published var debtors = [Debtor]() {
		didSet {
			LocalDataSource.saveDataOf(debtors, forKey: "Debtors")
		}
	}
	
	// MARK: - Codable conformance for @Published properties
	enum CodingKeys: CodingKey {
		case bills, creditors, debtors
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		
		try container.encode(bills, forKey: .bills)
		try container.encode(creditors, forKey: .creditors)
		try container.encode(debtors, forKey: .debtors)
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		bills = try container.decode([Bill].self, forKey: .bills)
		creditors = try container.decode([Creditor].self, forKey: .creditors)
		debtors = try container.decode([Debtor].self, forKey: .debtors)
	}
	
	private init() {
		bills = LocalDataSource.loadDataFor(key: "Bills") ?? []
		creditors = LocalDataSource.loadDataFor(key: "Creditors") ?? []
		debtors = LocalDataSource.loadDataFor(key: "Debtors") ?? []
	}
	
	// MARK: - Coding & Loading Data
}

