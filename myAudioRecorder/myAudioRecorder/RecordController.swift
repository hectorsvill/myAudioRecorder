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
	var record: [Record] = []
	
	func fetchRecords() {
	
		let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
		let fetchResultController =  NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.mainContext, sectionNameKeyPath: nil, cacheName: nil)
		
		CoreDataStack.shared.mainContext.performAndWait {
			do {
				try fetchResultController.performFetch()
				record = fetchResultController.fetchedObjects ??  []
				
			} catch {
				NSLog("Error fetching results from store: \(error)")
			}
		}
	}

	
	
}
