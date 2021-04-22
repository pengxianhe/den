//
//  Page+CoreDataClass.swift
//  Den
//
//  Created by Garrett Johnson on 7/30/20.
//  Copyright © 2020 Garrett Johnson. All rights reserved.
//

import Foundation
import CoreData

@objc(Page)
public class Page: NSManagedObject {
    public var wrappedName: String {
        get { name ?? "Untitled" }
        set { name = newValue }
    }
    
    public var wrappedItemsPerFeed: Int {
        get { Int(itemsPerFeed) }
        set { itemsPerFeed = Int16(newValue) }
    }
    
    public var unreadCount: Int {
        get {            
            subscriptionsArray.reduce(0) { (result, subscription) -> Int in
                if let feed = subscription.feed {
                    return result + min(self.wrappedItemsPerFeed, feed.unreadItemCount)
                } else {
                    return 0
                }
            }
        }
    }
    
    public var subscriptionsArray: [Subscription] {
        get {
            guard let subscriptions = self.subscriptions else { return [] }
            return subscriptions.sortedArray(using: [NSSortDescriptor(key: "userOrder", ascending: true)]) as! [Subscription]
        }
        set {
            subscriptions = NSSet(array: newValue)
        }
    }
    
    public var subscriptionsUserOrderMin: Int16 {
        subscriptionsArray.reduce(0) { (result, subscription) -> Int16 in
            if subscription.userOrder < result {
                return subscription.userOrder
            }
            return result
        }
    }
    
    public var subscriptionsUserOrderMax: Int16 {
        subscriptionsArray.reduce(0) { (result, subscription) -> Int16 in
            if subscription.userOrder > result {
                return subscription.userOrder
            }
            return result
        }
    }
    
    public var minimumRefreshedDate: Date? {
        subscriptionsArray.sorted { a, b in
            if let aRefreshed = a.feed?.refreshed,
               let bRefreshed = b.feed?.refreshed {
                return aRefreshed < bRefreshed
            }
            return false
        }.first?.feed?.refreshed
    }
    
    static func create(in managedObjectContext: NSManagedObjectContext) -> Page {
        do {
            let pages = try managedObjectContext.fetch(Page.fetchRequest())
            
            let newPage = self.init(context: managedObjectContext)
            newPage.id = UUID()
            newPage.userOrder = Int16(pages.count + 1)
            newPage.name = "New Page"
            newPage.itemsPerFeed = Int16(5)
            
            return newPage
        } catch {
            fatalError("Unable to create new page: \(error)")
        }
    }
}

extension Collection where Element == Page, Index == Int {
    
    func delete(at indices: IndexSet, from managedObjectContext: NSManagedObjectContext) {
        indices.forEach { managedObjectContext.delete(self[$0]) }
 
        do {
            try managedObjectContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}