//
//  LocalDataStore.swift
//  Discounter
//
//  Created by Wissa Michael on 18.04.21.
//

import Foundation

struct LocalDataSource {
	static func loadDataFor<T: Codable>(key: String) -> T? {
		if let data = UserDefaults.standard.data(forKey: key) {
			let decoder = JSONDecoder()
			if let decodedItems = try? decoder.decode(T.self, from: data) {
				return decodedItems
			}
		}
		
		return nil
	}
	
	static func saveDataOf<T: Codable>(_ data: T, forKey key: String) {
		if let encodedData = try? JSONEncoder().encode(data) {
			UserDefaults.standard.setValue(encodedData, forKey: key)
		}
	}
}
