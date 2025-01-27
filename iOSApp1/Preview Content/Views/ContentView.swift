//
//  ContentView.swift
//  iOSApp1
//
//  Created by Cristina Cabral on 2025-01-26.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        NavigationView {
                    ZStack {
                        // Gradient background
                        LinearGradient(gradient: Gradient(colors: [Color.red, Color.white]),
                                       startPoint: .top, endPoint: .bottom)
                            .edgesIgnoringSafeArea(.all)  // Make the gradient fill the whole screen
 
                        VStack {
                            Image(systemName: "cup.and.heat.waves.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(Color.black)  // Brown color for the image
                            
                            Text("Coffee Run")
                                .font(.largeTitle)
                                .foregroundColor(.white)  // Make sure the text is visible
 
                            // NavigationLink wrapped around the button to go to OrderCreationView
                            NavigationLink(destination: OrderCreationView()) {
                                Text("Start Order")
                                    .font(.title)
                                    .padding()
                                    .background(Color.white)
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                                    .shadow(radius: 10)
                            }
                        }
                        .padding()
                    }
                }
            }
        }
 
#Preview {
    ContentView()
}
