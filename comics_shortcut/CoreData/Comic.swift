//
//  CoreModel.swift
//  comics_shortcut
//
//  Created by Heine Fjeldberg on 09/11/2022.
//

import CoreData

@objc(Comic)
class Comic: NSManagedObject
{
    @NSManaged var id: NSNumber
    @NSManaged var title: String?
}
