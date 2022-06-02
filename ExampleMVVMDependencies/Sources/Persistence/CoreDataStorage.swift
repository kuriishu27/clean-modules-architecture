//
//  CoreDataStorage.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 26/03/2020.
//

import CoreData

public enum CoreDataStorageError: Error {
	case readError(Error)
	case saveError(Error)
	case deleteError(Error)
}

public protocol PersistenceManager {
	var viewContext: NSManagedObjectContext { get }
}

open class PersistentContainer: NSPersistentContainer {
}

public final class CoreDataStorage {
	
	public static let shared = CoreDataStorage()
	
	private init() {}
	
	// MARK: - Core Data stack
	private lazy var persistentContainer: PersistentContainer? = {
		guard let modelURL = Bundle.module.url(forResource:"CoreDataStorage", withExtension: "momd") else { return nil }
		
		guard let model = NSManagedObjectModel(contentsOf: modelURL) else { return nil }
		let container = PersistentContainer(
			name:"Persistence",
			managedObjectModel: model
		)
		
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				print("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()
	
	// MARK: - Core Data Saving support
	public func saveContext() {
		guard let context = persistentContainer?.viewContext else {
			return
		}
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				// TODO: - Log to Crashlytics
				assertionFailure("CoreDataStorage Unresolved error \(error), \((error as NSError).userInfo)")
			}
		}
	}
	
	public func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
		persistentContainer?.performBackgroundTask(block)
	}
}
