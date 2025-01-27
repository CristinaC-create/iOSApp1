//
//  UserProfile.swift
//  iOSApp1
//
//  Created by Cristina Cabral on 2025-01-27.
//

import SwiftUI

struct UserProfile: Identifiable {
    var id: UUID
    var name: String
    var orderHistory: [CoffeeOrder] // Array of CoffeeOrder
}

struct userProfile: Identifiable {
    var id: UUID
    var name: String
    var orderHistory: [CoffeeOrder]
}

struct CoffeeOrder: Identifiable {
    var id: UUID
    var name: String
    var drinkType: String
    var size: String
    var customizations: [String]
    var notes: String
}

struct Profile: View {
    var user: User
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    // User's name
                    Text(user.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    Divider()
                    
                    // Order History Section
                    Text("Order History")
                        .font(.title2)
                        .padding(.top)
                    
                    // List of Coffee Orders
                    if user.orderHistory.isEmpty {
                        Text("No orders yet.")
                            .foregroundColor(.black)
                            .italic()
                            .padding(.top)
                    } else {
                        ForEach(user.orderHistory) { order in
                            OrderRowView(order: order)  // Custom row for displaying each order
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
            // Gradient Background
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.red, .white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
            )
            .navigationBarTitle("User Summary", displayMode: .inline)
            .navigationBarItems(leading: backButton)
        }
    }
    
    private var backButton: some View {
        Button(action: {
            print("Back button tapped")
        }) {
            Image(systemName: "arrow.left.circle.fill")
                .imageScale(.large)
                .foregroundColor(.blue)
        }
    }
}

struct OrderRowView: View {
    var order: CoffeeOrder
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(order.drinkType)
                    .font(.headline)
                Spacer()
                Text(order.size)
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
            
            Text("Customizations: \(order.customizations.joined(separator: ", "))")
                .font(.body)
                .foregroundColor(.black)
            
            if !order.notes.isEmpty {
                Text("Notes: \(order.notes)")
                    .font(.body)
                    .italic()
                    .foregroundColor(.black)
            }
            
            Divider()
        }
        .padding(.vertical)
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        let sampleOrders = [
            CoffeeOrder(id: UUID(), name: "Valeria Sosa", drinkType: "Latte", size: "Medium", customizations: ["Non-fat Milk", "Extra Shot"], notes: "No Foam"),
            CoffeeOrder(id: UUID(), name: "Valeria Sosa", drinkType: "Cappuccino", size: "Large", customizations: ["Oat Milk"], notes: "Extra Hot"),
            CoffeeOrder(id: UUID(), name: "Valeria Sosa", drinkType: "Espresso", size: "Small", customizations: ["No Extras"], notes: "Extra Hot, Double Cup"),
            CoffeeOrder(id: UUID(), name: "Valeria Sosa", drinkType: "Frappuccino", size: "Medium", customizations: ["Oat Milk"], notes: "Extra Hot and Extra Cream")
        ]
        
        let sampleUser = User(id: UUID(), name: "Valeria Sosa", orderHistory: sampleOrders)
        
        return Profile(user: sampleUser)
    }
}
