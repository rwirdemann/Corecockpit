//
//  ContentView.swift
//  Fitnesscockpit
//
//  Created by Ralf Wirdemann on 17.12.22.
//

import SwiftUI
import CoreData

struct ActivitiesView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors:
            [NSSortDescriptor(keyPath: \Activity.phase, ascending: true),
             NSSortDescriptor(keyPath: \Activity.name, ascending: false)],
        animation: .default)
    private var warmups: FetchedResults<Activity>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(warmups) { item in
                    NavigationLink {
                        ActivityDetailView(activity: item)
                    } label: {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(item.name!) (\(item.repititions ?? ""))")
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            Text("\(item.phase!) - \(item.bodyPart!)")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Activities")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    NavigationLink(destination: CreateActivityView(),
                                   label: {Image(systemName: "plus")})
                }
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { warmups[$0] }.forEach(viewContext.delete)

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
