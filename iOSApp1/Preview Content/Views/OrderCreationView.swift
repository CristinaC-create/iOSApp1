//
//  OrderCreationView.swift
//  iOSApp1
//
//  Created by Cristina Cabral on 2025-01-27.
//
import SwiftUI
import CoreData

struct OrderCreation: Identifiable {
    var id: UUID
    var name: String
    var drinkType: String
    var size: String
    var customizations: [String]
    var notes: String
}

struct OrderCreationView: View {
    @Environment(\.managedObjectContext) private var viewContext

    // Coffee Order State
    @State private var coffeeOrder = OrderCreation(
        id: UUID(),
        name: "",
        drinkType: "",
        size: "",
        customizations: [],
        notes: ""
    )

    // Data Sources
    @State private var availableSizes = ["Small", "Medium", "Large"]
    @State private var availableDrinkTypes = ["Light Roast", "Medium Roast", "Dark Roast", "Espresso", "Latte", "Cappuccino", "Frappuccino", "Black Coffee"]
    @State private var availableCustomizations = ["Extra Shot", "Milk", "Non-fat Milk (Skim Milk)", "Cream", "Sugar", "Extra Whip Cream", "No Foam"]

    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                gradient: Gradient(colors: [Color.red, Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            VStack {
                // Customer Info Section
                Section(header: Text("Customer Information").font(.headline)) {
                    TextField("Your Name", text: $coffeeOrder.name)
                        .autocapitalization(.words)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.top)

                // Drink Type and Size Picker
                Section(header: Text("Brew Details").font(.headline)) {
                    Picker("Select Drink Type", selection: $coffeeOrder.drinkType) {
                        ForEach(availableDrinkTypes, id: \.self) { drink in
                            Text(drink)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())

                    Picker("Select Size", selection: $coffeeOrder.size) {
                        ForEach(availableSizes, id: \.self) { size in
                            Text(size)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                // Customizations Section
                Section(header: Text("Customizations").font(.headline)) {
                    ForEach(availableCustomizations, id: \.self) { customization in
                        Toggle(customization, isOn: Binding(
                            get: { coffeeOrder.customizations.contains(customization) },
                            set: { isOn in
                                if isOn {
                                    coffeeOrder.customizations.append(customization)
                                } else {
                                    coffeeOrder.customizations.removeAll { $0 == customization }
                                }
                            }
                        ))
                    }
                }

                // Special Notes Section
                Section(header: Text("Special Requests").font(.headline)) {
                    TextField("Do You Have More To Add?", text: $coffeeOrder.notes)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical)
                }

                // Submit Button
                Section {
                    Button(action: {
                        submitOrder()
                    }) {
                        Text("Submit Order")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.top)
                }
            }
            .padding()
        }
        .navigationTitle("Create Your Coffee Order")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Submit Order Function
    private func submitOrder() {
        print("Order Submitted: \(coffeeOrder)")
        saveOrder() // Call saveOrder to persist the data
    }

    // Save Order Function
    private func saveOrder() {
        let newOrder = CoffeeOrderEntity(context: viewContext)
        newOrder.id = coffeeOrder.id
        newOrder.name = coffeeOrder.name
        newOrder.drinkType = coffeeOrder.drinkType
        newOrder.size = coffeeOrder.size
        newOrder.customizations = coffeeOrder.customizations.joined(separator: ", ")
        newOrder.notes = coffeeOrder.notes

        do {
            try viewContext.save()
            print("Order saved successfully!")
        } catch {
            print("Failed to save order: \(error.localizedDescription)")
        }
    }
}

// Preview
struct OrderCreationView_Previews: PreviewProvider {
    static var previews: some View {
        OrderCreationView()
    }
}
