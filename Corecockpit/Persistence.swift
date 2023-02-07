//
//  Persistence.swift
//  Fitnesscockpit
//
//  Created by Ralf Wirdemann on 17.12.22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Fitnesscockpit")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        populateDatabase(context: container.viewContext,
                         name: "Back Extensions", phase: "Warmup", repititions: "10",
                         rubber: Constants.RUBBER[0],
                         bodyPart: Constants.BODY_PARTS[0],
                         desc: ""
        )
        populateDatabase(context: container.viewContext,
                         name: "Bankdrücken", phase: "Warmup", repititions: "10",
                         rubber: Constants.RUBBER[0],
                         bodyPart: Constants.BODY_PARTS[0],
                         desc: ""
        )
        populateDatabase(context: container.viewContext,
                         name: "Cossack Squats", phase: "Warmup", repititions: Constants.REPITITIONS[5],
                         rubber: Constants.RUBBER[0],
                         bodyPart: Constants.BODY_PARTS[2],
                         desc: ""
        )
        populateDatabase(context: container.viewContext,
                         name: "Lunges with Rotation", phase: "Warmup", repititions: Constants.REPITITIONS[5],
                         rubber: Constants.RUBBER[0],
                         bodyPart: Constants.BODY_PARTS[0],
                         desc: "Auf der Seite des vorderen Beins nach außen drehen."
        )
        populateDatabase(context: container.viewContext,
                         name: "Shoulder Tabs", phase: "Warmup", repititions: Constants.REPITITIONS[5],
                         rubber: Constants.RUBBER[0],
                         bodyPart: Constants.BODY_PARTS[0],
                         desc: ""
        )
        populateDatabase(context: container.viewContext,
                         name: "Side Crunches", phase: "Warmup", repititions: Constants.REPITITIONS[5],
                         rubber: Constants.RUBBER[0],
                         bodyPart: Constants.BODY_PARTS[0],
                         desc: ""
        )
        populateDatabase(context: container.viewContext,
                         name: "Situps", phase: "Warmup",
                         repititions: Constants.REPITITIONS[4],
                         rubber: Constants.RUBBER[0],
                         bodyPart: Constants.BODY_PARTS[0],
                         desc: ""
        )
        populateDatabase(context: container.viewContext,
                         name: "Lunges Back", phase: "Warmup",
                         repititions: Constants.REPITITIONS[5],
                         rubber: Constants.RUBBER[0],
                         bodyPart: Constants.BODY_PARTS[0],
                         desc: ""
        )
        populateDatabase(context: container.viewContext,
                         name: "Lunges", phase: "Workout",
                         repititions: "10/10",
                         rubber: Constants.RUBBER[0],
                         bodyPart: Constants.BODY_PARTS[0],
                         desc: "Ausfallschritt nach vorne, hinteres Knie fast auf dem Boden"
                         )
        populateDatabase(context: container.viewContext,
                         name: "Tiefe Kniebeuge", phase: "Workout",
                         repititions: "15",
                         rubber: Constants.RUBBER_NONE,
                         bodyPart: Constants.LOWER_BODY,
                         desc: ""
        )
        populateDatabase(context: container.viewContext,
                         name: "Tiefe Kniebeuge lang", phase: "Workout",
                         repititions: "10",
                         rubber: Constants.RUBBER_NONE,
                         bodyPart: Constants.LOWER_BODY,
                         desc: "3 Sekunden unten bleiben"
        )
        populateDatabase(context: container.viewContext,
                         name: "Rudern Tube Untergriff", phase: "Workout",
                         repititions: Constants.REPITITIONS_TWELVE_TWELVE,
                         rubber: Constants.RUBBER_BLACK_RED,
                         bodyPart: Constants.CORE,
                         desc: ""
        )
        populateDatabase(context: container.viewContext,
                         name: "Rudern Tube Obergriff", phase: "Workout",
                         repititions: Constants.REPITITIONS_TWELVE_TWELVE,
                         rubber: Constants.RUBBER_BLACK_RED,
                         bodyPart: Constants.CORE,
                         desc: ""
        )
        populateDatabase(context: container.viewContext,
                         name: "Rudern Tube Hammergriff", phase: "Workout",
                         repititions: Constants.REPITITIONS_TWELVE_TWELVE,
                         rubber: Constants.RUBBER_BLACK_RED,
                         bodyPart: Constants.CORE,
                         desc: ""
        )
        populateDatabase(context: container.viewContext,
                         name: "Buttefly Tube", phase: "Workout",
                         repititions: Constants.REPITITIONS_TWELVE_TWELVE,
                         rubber: Constants.RUBBER_BLACK_RED,
                         bodyPart: Constants.UPPER_BODY,
                         desc: ""
        )
        populateDatabase(context: container.viewContext,
                         name: "Facepulls Tube", phase: "Workout",
                         repititions: Constants.REPITITIONS_TWELVE,
                         rubber: Constants.RUBBER_GREEN,
                         bodyPart: Constants.UPPER_BODY,
                         desc: ""
        )
        populateDatabase(context: container.viewContext,
                         name: "Rumpfrotation Tube", phase: "Workout",
                         repititions: Constants.REPITITIONS_TWELVE_TWELVE,
                         rubber: Constants.RUBBER_GREEN,
                         bodyPart: Constants.CORE,
                         desc: ""
        )
        populateDatabase(context: container.viewContext,
                         name: "Standwage", phase: "Workout",
                         repititions: Constants.REPITITIONS_FIVE_FIVE,
                         rubber: Constants.RUBBER_NONE,
                         bodyPart: Constants.CORE,
                         desc: ""
        )
        populateDatabase(context: container.viewContext,
                         name: "Buttefly Tube Reverse", phase: "Workout",
                         repititions: Constants.REPITITIONS_TEN_TEN,
                         rubber: Constants.RUBBER_RED,
                         bodyPart: Constants.UPPER_BODY,
                         desc: ""
        )
        populateDatabase(context: container.viewContext,
                         name: "Rudern Untergriff", phase: "Workout",
                         repititions: Constants.REPITITIONS_TEN,
                         rubber: Constants.RUBBER_NONE,
                         bodyPart: Constants.UPPER_BODY,
                         desc: ""
        )
        populateDatabase(context: container.viewContext,
                         name: "Bulgarian Split Squats", phase: "Workout",
                         repititions: Constants.REPITITIONS_TEN_TEN,
                         rubber: Constants.RUBBER_NONE,
                         bodyPart: Constants.UPPER_BODY,
                         desc: ""
        )
        populateDatabase(context: container.viewContext,
                         name: "Around the World Tube", phase: "Workout",
                         repititions: Constants.REPITITIONS_TWELVE,
                         rubber: Constants.RUBBER_YELLOW,
                         bodyPart: Constants.UPPER_BODY,
                         desc: ""
        )
        populateDatabase(context: container.viewContext,
                         name: "Around the World Tube", phase: "Workout",
                         repititions: Constants.REPITITIONS_TWELVE,
                         rubber: Constants.RUBBER_YELLOW,
                         bodyPart: Constants.UPPER_BODY,
                         desc: ""
        )
        populateDatabase(context: container.viewContext,
                         name: "Bankdrücken Tube", phase: "Workout",
                         repititions: Constants.REPITITIONS_TWELVE_TWELVE,
                         rubber: Constants.RUBBER_BLACK_RED,
                         bodyPart: Constants.UPPER_BODY,
                         desc: ""
        )
        populateDatabase(context: container.viewContext,
                         name: "Pistol Squats", phase: "Workout",
                         repititions: Constants.REPITITIONS_FIVE_FIVE,
                         rubber: Constants.RUBBER_NONE,
                         bodyPart: Constants.LOWER_BODY,
                         desc: "Einbeinige Kniebeuge mit gestrecktem Bein."
        )
        populateDatabase(context: container.viewContext,
                         name: "Butterfly Reverse Arm Kombi",
                         phase: "Workout",
                         repititions: Constants.REPITITIONS_TWELVE,
                         rubber: Constants.RUBBER_YELLOW,
                         bodyPart: Constants.UPPER_BODY,
                         desc: "Butterfly Reverse ein Arm nach oben anderer nach unten."
        )
    }
    
    private func populateDatabase(context: NSManagedObjectContext, name: String, phase: String, repititions: String, rubber: String, bodyPart: String, desc: String) {
        let fetchRequest: NSFetchRequest<Activity> = Activity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        let test = try! context.fetch(fetchRequest)
        if test.count == 0 {
            let a = Activity(context: context)
            a.name = name
            a.phase = phase
            a.repititions = repititions
            a.rubber = rubber
            a.bodyPart = bodyPart
            a.desc = desc
            try! context.save()
        }
    }
}


