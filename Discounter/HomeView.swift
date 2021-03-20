//
//  HomeView.swift
//  Discounter
//
//  Created by Wissa Michael on 19.03.21.
//

import SwiftUI

struct HomeView: View {
	@ObservedObject var expenses: Expenses
	@State private var billId = UUID()
	@State private var showingCreateBillView = false
	
    var body: some View {
		NavigationView{
			List {
				ForEach(expenses.bills) { bill in
					NavigationLink(destination: BillDetailsView(bill: bill)) {
						VStack {
							HStack {
								Text(bill.name)
									.font(.headline)
								Spacer()
								Text("\(Localization.Home.paid) \(bill.totalAfterSale, specifier: "%.2f")")
							}
							HStack {
								Text("\(Localization.General.items) \(bill.items.count)")
								Spacer()
								if bill.amountSaved > 0 {
									Text("\(Localization.Home.saved) \(bill.amountSaved, specifier: "%.2f")")
								}
							}
						}
					}
				}
			}
			
			.navigationBarTitle(Localization.Home.allBills)
			.navigationBarItems(trailing: Button(action: {
				self.showingCreateBillView.toggle()
			}){
				Image(systemName: "plus")
			})
			
			.sheet(isPresented: $showingCreateBillView){
				AddBillView(expenses: expenses)
			}
		}
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(expenses: Expenses())
    }
}
