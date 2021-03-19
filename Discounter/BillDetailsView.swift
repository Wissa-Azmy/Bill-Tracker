//
//  CreateBillView.swift
//  Discounter
//
//  Created by Wissa Michael on 19.03.21.
//

import SwiftUI

struct BillDetailsView: View {
	@Environment(\.presentationMode) var presentationMode
	
    var body: some View {
		VStack{
			Button("dismiss") {
				presentationMode.wrappedValue.dismiss()
			}
			Text("Create a new Bill here")
		}
    }
}

struct CreateBillView_Previews: PreviewProvider {
    static var previews: some View {
        BillDetailsView()
    }
}
