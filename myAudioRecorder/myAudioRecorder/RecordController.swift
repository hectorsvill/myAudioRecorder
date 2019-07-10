//
//  RecordController.swift
//  myAudioRecorder
//
//  Created by Hector Steven on 7/9/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation
import CoreData

class RecordController {
	private (set) var records: [Record] = []
	
	func fetchRecords() {
		let context = CoreDataStack.shared.mainContext
		let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
		fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
		let fetchResultController =  NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.mainContext, sectionNameKeyPath: nil, cacheName: nil)
		
		context.performAndWait {
			do {
				try fetchResultController.performFetch()
				records = fetchResultController.fetchedObjects ??  []
				
			} catch {
				NSLog("Error fetching results from store: \(error)")
			}
		}
	}

	
	func addRecord(url: String) {
		let record = Record(url: url)
		records.append(record)
		try? CoreDataStack.shared.save(context: CoreDataStack.shared.mainContext)
	}
	
	
	
}
