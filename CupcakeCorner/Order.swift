//
//  Order.swift
//  CupcakeCorner
//
//  Created by Vinicius Ledis on 01/04/2024.
//

import Foundation

@Observable
class Order: Codable {

    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type: Int
    var quantity: Int
    
    var specialRequestEnabled: Bool {
        didSet {
            if specialRequestEnabled == false {
                extraFrostring = false
                addSprinkles = false
            }
        }
    }
    var extraFrostring: Bool
    var addSprinkles: Bool
    
    var name: String {
        didSet {
            saveAddress()
        }
    }
    var streetAddress: String {
        didSet {
            saveAddress()
        }
    }
    var city: String {
        didSet {
            saveAddress()
        }
    }
    var zip: String {
        didSet {
            saveAddress()
        }
    }
    
    init(type: Int = 0, quantity: Int = 3, specialRequestEnabled: Bool = false, extraFrostring: Bool = false, addSprinkles: Bool = false, name: String = "", streetAddress: String = "", city: String = "", zip: String = "") {
            self.type = type
            self.quantity = quantity
            self.specialRequestEnabled = specialRequestEnabled
            self.extraFrostring = extraFrostring
            self.addSprinkles = addSprinkles
            self.name = name
            self.streetAddress = streetAddress
            self.city = city
            self.zip = zip
            
            if let savedAddress = UserDefaults.standard.data(forKey: "SavedAddress") {
                let decoder = JSONDecoder()
                if let loadedAddress = try? decoder.decode(Order.self, from: savedAddress) {
                    self.name = loadedAddress.name
                    self.streetAddress = loadedAddress.streetAddress
                    self.city = loadedAddress.city
                    self.zip = loadedAddress.zip
                    return
                }
            }
        }
    
    private func saveAddress() {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(self) {
                UserDefaults.standard.set(encoded, forKey: "SavedAddress")
            }
        }
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2
        
        // complicated cakes cost more
        cost += Decimal(type) / 2
        
        // $1/cake for extra frosting
        if extraFrostring {
            cost += Decimal(quantity)
        }
        
        // $0.5/cake for extra sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        return cost
    }
}
