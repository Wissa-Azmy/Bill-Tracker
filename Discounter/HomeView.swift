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
					HStack {
						Text(bill.name)
						Spacer()
						Text("\(bill.items.count)")
					}
				}
				.onTapGesture {
					showingCreateBillView.toggle()
				}
			}
			
			.navigationBarTitle("All Bills")
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
