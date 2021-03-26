//
//  CodeTemplates.swift
//  Discounter
//
//  Created by Wissa Michael on 21.03.21.
//





/*
Section {
	Toggle(isOn: $order.specialRequestEnabled.animation()) {
		Text("Any special requests?")
	}

	if order.specialRequestEnabled {
		Toggle(isOn: $order.extraFrosting) {
			Text("Add extra frosting")
		}

		Toggle(isOn: $order.addSprinkles) {
			Text("Add extra sprinkles")
		}
	}
}

enum CodingKeys: CodingKey {
	case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
}

func encode(to encoder: Encoder) throws {
	var container = encoder.container(keyedBy: CodingKeys.self)

	try container.encode(type, forKey: .type)
	try container.encode(quantity, forKey: .quantity)

	try container.encode(extraFrosting, forKey: .extraFrosting)
	try container.encode(addSprinkles, forKey: .addSprinkles)

	try container.encode(name, forKey: .name)
	try container.encode(streetAddress, forKey: .streetAddress)
	try container.encode(city, forKey: .city)
	try container.encode(zip, forKey: .zip)
}

init() { }

required init(from decoder: Decoder) throws {
	let container = try decoder.container(keyedBy: CodingKeys.self)

	type = try container.decode(Int.self, forKey: .type)
	quantity = try container.decode(Int.self, forKey: .quantity)

	extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
	addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)

	name = try container.decode(String.self, forKey: .name)
	streetAddress = try container.decode(String.self, forKey: .streetAddress)
	city = try container.decode(String.self, forKey: .city)
	zip = try container.decode(String.self, forKey: .zip)
}

let url = URL(string: "https://reqres.in/api/cupcakes")!
var request = URLRequest(url: url)
request.setValue("application/json", forHTTPHeaderField: "Content-Type")
request.httpMethod = "POST"
request.httpBody = encoded

URLSession.shared.dataTask(with: request) { data, response, error in
	// handle the result here.
	guard let data = data else {
		print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
		return
	}
}.resume()


//			.navigationBarItems(trailing: Button(action: {
//				self.showingCreateBillView.toggle()
//			}){
//				Image(systemName: "plus")
//			})


*/
