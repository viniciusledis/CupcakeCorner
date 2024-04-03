//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Vinicius Ledis on 01/04/2024.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: Binding(
                    get: { self.order.name },
                    set: { newValue in
                        // Verifica se o novo valor contém apenas espaços em branco
                        if !newValue.trimmingCharacters(in: .whitespaces).isEmpty {
                            self.order.name = newValue
                        }
                    }
                ))
                    .autocorrectionDisabled()
                    
                TextField("Street Address", text: Binding(
                    get: { self.order.streetAddress },
                    set: { newValue in
                        if !newValue.trimmingCharacters(in: .whitespaces).isEmpty {
                            self.order.streetAddress = newValue
                        }
                    }
                ))
                    .autocorrectionDisabled()
                
                TextField("City", text: Binding(
                    get: { self.order.city },
                    set: { newValue in
                        if !newValue.trimmingCharacters(in: .whitespaces).isEmpty {
                            self.order.city = newValue
                        }
                    }
                ))
                    .autocorrectionDisabled()
                TextField("Zip Code", text: Binding(
                    get: { self.order.zip },
                    set: { newValue in
                        if !newValue.trimmingCharacters(in: .whitespaces).isEmpty {
                            self.order.zip = newValue
                        }
                    }
                ))
                    .autocorrectionDisabled()
            }
            
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
    }
}

#Preview {
    AddressView(order: Order())
}
