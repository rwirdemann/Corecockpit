//
//  ContentView.swift
//  Fitnesscockpit
//
//  Created by Ralf Wirdemann on 18.12.22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        TabView {
            ExcercisesView()
                .tabItem {
                    Image(systemName: "figure.cooldown")
                    Text("Excercises")
                }

            ActivitiesView()
                .tabItem {
                    Image(systemName: "figure.core.training")
                    Text("Activities")
                }
        }
    }}
