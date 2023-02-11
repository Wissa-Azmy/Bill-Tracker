//
//  Payment.swift
//  Discounter
//
//  Created by Wissa Michael on 18.04.21.
//

import Foundation
import FirebaseFirestoreSwift

struct Payment: Identifiable, Codable, Hashable {
	@DocumentID var id: String?
    let amount: Double
    let date: Date
}
