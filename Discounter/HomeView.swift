//
//  HomeView.swift
//  Discounter
//
//  Created by Wissa Michael on 19.03.21.
//

import SwiftUI

struct HomeView: View {
	@State private var showingCreateBillView = false
	
    var body: some View {
		NavigationView{
			Text("Home view, where you find all your bills")
			
			.navigationBarTitle("All Bills")
			.navigationBarItems(trailing: Button("add", action: {
				self.showingCreateBillView.toggle()
			}))
			
			.sheet(isPresented: $showingCreateBillView){
				CreateBillView()
			}
		}
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
