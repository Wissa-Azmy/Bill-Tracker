//
//  CreditorRepository.swift
//  Discounter
//
//  Created by Wissa Michael on 17.04.21.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class CreditorRepository: ObservableObject {
	var userId = ""
	private let path = "cards"
	private let store = Firestore.firestore()
	private let authenticationService = AuthenticationService()
	private var cancellables = Set<AnyCancellable>()
	
	@Published var creditors = [Credit]()
	
	/// 1- Bind user‘s id from AuthenticationService to the repository’s userId. It also stores the object in cancellables so it can be canceled later.
	/// 2- This code observes the changes in user, uses receive(on:options:) to set the thread where the code will execute
	///  and then attaches a subscriber using sink(receiveValue:). This guarantees that when you get a user from AuthenticationService,
	///  the code in the closure executes in the main thread.
	init() {
//		authenticationService.$user.compactMap { user in
//			user?.uid
//		}.assign(to: \.userId, on: self).store(in: &cancellables)
//
//		authenticationService.$user.receive(on: DispatchQueue.main).sink { [weak self] _ in
//			self?.getCreditors()
//		}.store(in: &cancellables)
		
		getCreditors()
	}
	
	private func getCreditors() {
		store.collection(path).whereField("userId", isEqualTo: userId).addSnapshotListener { (querySnapshot, error) in
			guard error == nil else { print(error?.localizedDescription ?? "") ; return }
			
			self.creditors = querySnapshot?.documents.compactMap { document in
				try? document.data(as: Credit.self)
			} ?? []
		}
	}
	
	func add(_ creditor: Credit) {
		do {
			_ = try store.collection(path).addDocument(from: creditor)
		} catch {
			assertionFailure("Unable to add card: \(error.localizedDescription)")
		}
	}
	
	/// Update single card data
	/// To achieve this: a @DocumentID wrapped property must be provided in the data model
	/// This property is then used to identify the document to update  and leaving this property untouched on the firestore side
	/// - Parameter card: Card
	func update(_ creditor: Credit) {
		guard let creditorId = creditor.id else { return }
		
		do {
			try store.collection(path).document(creditorId).setData(from: creditor)
		} catch {
			assertionFailure(error.localizedDescription)
		}
	}
	
	func remove(_ creditor: Credit) {
		guard let creditorId = creditor.id else { return }
		
		store.collection(path).document(creditorId).delete { error in
			if let errorDesc = error?.localizedDescription {
				print(errorDesc)
			}
		}
	}
	
}
