//
//  AddCreditorView.swift
//  Discounter
//
//  Created by Wissa Michael on 22.03.21.
//

import SwiftUI

struct AddCreditorView: View {
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var expenses: Expenses
	
    var body: some View {
		NavigationView {
			Text("Hello, Creditor!")
			
				.navigationTitle("Add New Creditor")
		}
    }
}

struct AddCreditorView_Previews: PreviewProvider {
    static var previews: some View {
        AddCreditorView(expenses: Expenses())
    }
}
