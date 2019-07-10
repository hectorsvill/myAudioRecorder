//
//  Convenience+Media.swift
//  myAudioRecorder
//
//  Created by Hector Steven on 7/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation
import CoreData

extension Media {
	
	convenience init(name: String, typee: String , date: Date = Date(), context: NSManagedObjectContext = CoreDataStack.shared.mainContext ) {
		self.init(context: context)
		self.name = name
		self.type = type
		self.date = date
	}
	
	
}
