//
//  HomeView.swift
//  Discounter
//
//  Created by Wissa Michael on 19.03.21.
//

import SwiftUI

struct HomeView: View {
	@ObservedObject var expenses: Expenses
	@State private var showingAddNewItemSheet = false
	@State private var expensesSections = ["Creditors", "Debtors", "Bills"]
	@State private var filterSelectionIndex = 0
	@State private var addNewItemSectionIndex = 0
	private var title: String {
		expensesSections[filterSelectionIndex]
	}
	
	private func showAddNewItemSheet(for section: Int) {
		addNewItemSectionIndex = section
		showingAddNewItemSheet.toggle()
	}
	
    var body: some View {
		NavigationView{
			VStack {
				Picker("Filter", selection: $filterSelectionIndex) {
					ForEach(expensesSections.indices) {
						Text(expensesSections[$0])
					}
				}
				.pickerStyle(SegmentedPickerStyle())
				.padding()
				
				switch filterSelectionIndex {
					case 0:
						CreditorsListView(creditors: $expenses.creditors)
					case 1:
						DebtorsListView(debtors: $expenses.debtors)
					case 2:
						BillsListView(bills: $expenses.bills)
					default:
						Text("Placeholder")
				}
			}
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Menu {
						Button("Add New Creditor") { showAddNewItemSheet(for: 0) }
						Button("Add New Debtor") { showAddNewItemSheet(for: 1) }
						Button("Add New Bill") { showAddNewItemSheet(for: 2) }
					}
					label: {
						Image(systemName: "plus")
					}
					.font(.largeTitle)
				}
			}
			
			.navigationBarTitle(title)
			.sheet(isPresented: $showingAddNewItemSheet){
				switch addNewItemSectionIndex {
					case 0:
						AddCreditorView(expenses: expenses)
					case 1:
						AddDebtorView(expenses: expenses)
					case 2:
						AddBillView(expenses: expenses)
					default:
						Text("Placeholder")
				}
			}
		}
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(expenses: Expenses())
    }
}
