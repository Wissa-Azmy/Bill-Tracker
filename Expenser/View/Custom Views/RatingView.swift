//
//  RatingView.swift
//  Discounter
//
//  Created by Wissa Michael on 30.03.21.
//

import SwiftUI

struct RatingView: View {
	@Binding var rating: Int
	
	var maximumRating = 5
	
	var starImage = Image(systemName: "star.fill")
	
	var offColor = Color.gray
	var onColor = Color.yellow
	
    var body: some View {
		HStack {
			ForEach(1 ..< maximumRating + 1) { number in
				self.starImage
					.foregroundColor(number <= self.rating ? self.onColor : self.offColor)
					.onTapGesture { self.rating = number }
			}
		}
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
		RatingView(rating: .constant(4))
    }
}
