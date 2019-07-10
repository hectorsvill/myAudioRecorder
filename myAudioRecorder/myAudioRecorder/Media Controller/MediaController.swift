//
//  MediaController.swift
//  myAudioRecorder
//
//  Created by Hector Steven on 7/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation
import CoreData


class MediaController {
	var allMeddia: [Media] = []
	
	
	func fetchTracks() {
		
		let fetchRequest: NSFetchRequest<Media> = Media.fetchRequest()
		fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
		let fetchResultController =  NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.mainContext, sectionNameKeyPath: nil, cacheName: nil)
		
		CoreDataStack.shared.mainContext.performAndWait {
			do {
				try fetchResultController.performFetch()
				allMeddia = fetchResultController.fetchedObjects ??  []
				
			} catch {
				NSLog("Error fetching results from store: \(error)")
			}
		}
	}
	
	func addNewMedia(name: String, type: String) {
		let media = Media(
		
		
		try? CoreDataStack.shared.save(context: CoreDataStack.shared.mainContext)
	}

	
	
}
