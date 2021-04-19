//
//  ExpensesRepository.swift
//  Discounter
//
//  Created by Wissa Michael on 17.04.21.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class ExpensesRepository: ObservableObject {
//	var userId = ""
	private let path = "expenses"
	private let store = Firestore.firestore()
//	private let authenticationService = AuthenticationService()
	private var cancellables = Set<AnyCancellable>()
	
	@Published var expenses = [Expenses]()
	
	/// 1- Bind user‘s id from AuthenticationService to the repository’s userId. It also stores the object in cancellables so it can be canceled later.
	/// 2- This code observes the changes in user, uses receive(on:options:) to set the thread where the code will execute
	///  and then attaches a subscriber using sink(receiveValue:). This guarantees that when you get a user from AuthenticationService,
	///  the code in the closure executes in the main thread.
	init() {
		// 1
//		authenticationService.$user.compactMap { user in
//			user?.uid
//		}.assign(to: \.userId, on: self).store(in: &cancellables)
		// 2
//		authenticationService.$user.receive(on: DispatchQueue.main).sink { [weak self] _ in
//			self?.getCards()
//		}.store(in: &cancellables)
		
		getExpenses()
	}
	
	private func getExpenses() {
		store.collection(path).addSnapshotListener { (querySnapshot, error) in
			guard error == nil else { print(error?.localizedDescription ?? "") ; return }
			
			self.expenses = querySnapshot?.documents.compactMap { document in
				try? document.data(as: Expenses.self)
			} ?? []
		}
	}
	
	func add(_ expenses: Expenses) {
		do {
			_ = try store.collection(path).addDocument(from: expenses)
		} catch {
			assertionFailure("Unable to add Expenses: \(error.localizedDescription)")
		}
	}
	
	/// Update single card data
	/// To achieve this: a @DocumentID wrapped property must be provided in the data model
	/// This property is then used to identify the document to update  and leaving this property untouched on the firestore side
	/// - Parameter card: Card
	func update(_ expenses: Expenses) {
		guard let expensesId = expenses.id else { return }
		
		do {
			try store.collection(path).document(expensesId).setData(from: expenses)
		} catch {
			assertionFailure(error.localizedDescription)
		}
	}
	
	func remove(_ expenses: Expenses) {
		guard let expensesId = expenses.id else { return }
		
		store.collection(path).document(expensesId).delete { error in
			if let errorDesc = error?.localizedDescription {
				print(errorDesc)
			}
		}
	}
	
}
