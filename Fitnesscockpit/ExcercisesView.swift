//
//  ExcercisesView.swift
//  Fitnesscockpit
//
//  Created by Ralf Wirdemann on 18.12.22.
//

import SwiftUI
import CoreData

struct ExcercisesView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Excercise.when, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Excercise>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        ExcerciseDetailView(excercise: item)
                    } label: {
                        Text(item.when!, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Excercises")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    NavigationLink(destination: CreateExcerciseView(),
                                   label: {Image(systemName: "plus")})
                }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
