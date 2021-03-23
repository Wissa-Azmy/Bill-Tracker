//
//  PlaceholderImage.swift
//  Discounter
//
//  Created by Wissa Michael on 23.03.21.
//

import SwiftUI

struct PlaceholderImage: View {
	var name: String
	
	var body: some View {
		VStack {
			Spacer()
			Image(name)
			Spacer()
		}
	}
}

struct PlaceholderImage_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderImage(name: "no data")
    }
}
