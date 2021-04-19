//
//  Payment.swift
//  Discounter
//
//  Created by Wissa Michael on 18.04.21.
//

import Foundation
import FirebaseFirestoreSwift

struct Payment: Identifiable, Codable {
	@DocumentID var id: String?
	let date = Date()
	let amount: Double
}
