//
//  DetailsView.swift
//  Discounter
//
//  Created by Wissa Michael on 30.03.21.
//

import SwiftUI

struct DetailsView: View {
    var body: some View {
		GeometryReader { geometry in
			VStack {
				ZStack(alignment: .bottomTrailing) {
					Image("Fantasy")
						.resizable()
						.frame(maxWidth: geometry.size.width)
						.frame(maxHeight: geometry.size.height / 3)
						.scaledToFit()
					
					Text("FANTASY")
						.font(.caption)
						.fontWeight(.black)
						.padding(8)
						.foregroundColor(.white)
						.background(Color.black.opacity(0.5))
						.clipShape(Capsule())
						.offset(x: -10, y: -10)
				}
				
				Text("Unknown author")
					.font(.title)
					.foregroundColor(.secondary)
				
				Text("No review")
					.padding()
				
				RatingView(rating: .constant(3))
					.font(.largeTitle)
				
				Spacer()
			}
		}
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
    }
}
