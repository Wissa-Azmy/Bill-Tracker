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
	@State private var expensesSections = ["Credit", "Debts", "Bills"]
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
            ZStack(alignment: .bottomTrailing) {
                VStack {
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

                addMenuButton
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker("Filter", selection: $filterSelectionIndex) {
                        ForEach(expensesSections.indices) {
                            Text(expensesSections[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
            }

            .sheet(isPresented: $showingAddNewItemSheet){
                switch addNewItemSectionIndex {
                case 0:
                    let vm = AddCreditViewModel()
                    Sheet(
                        title: "Add Credit",
                        dismissButtonTitle: Localization.General.save,
                        dismissAction: vm.addCreditor
                    ) {
                        AddCreditorView(viewModel: vm)
                    }
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

    private var addMenuButton: some View {
        Menu {
            Button("Add Credit") { showAddNewItemSheet(for: 0) }
            Button("Add Debt") { showAddNewItemSheet(for: 1) }
            Button("Add Bill") { showAddNewItemSheet(for: 2) }
        }
        label: {
            Image(systemName: "plus.circle")
                .font(.system(size: 40))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(expenses: Expenses.shared)
    }
}
