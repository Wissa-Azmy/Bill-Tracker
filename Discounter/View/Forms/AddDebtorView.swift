//
//  AddDebtorView.swift
//  Discounter
//
//  Created by Wissa Michael on 22.03.21.
//

import SwiftUI

struct AddDebtorView: View {
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var expenses: Expenses
	
    var body: some View {
		NavigationView {
			Text("Hello, Debtor!")
				.navigationTitle("Add New Debtor")
		}
    }
}

struct AddDebtorView_Previews: PreviewProvider {
    static var previews: some View {
		AddDebtorView(expenses: Expenses())
    }
}
