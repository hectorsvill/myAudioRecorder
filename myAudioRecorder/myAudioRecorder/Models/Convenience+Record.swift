//
//  Convenience+Record.swift
//  myAudioRecorder
//
//  Created by Hector Steven on 7/9/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation
import CoreData

extension Record {
	
	convenience init (id: String = UUID().uuidString, url: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
		self.init(context: context)
		self.id = id
		self.url = url
	}
		
}
