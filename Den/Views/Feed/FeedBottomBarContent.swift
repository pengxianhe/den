//
//  FeedBottomBarContent.swift
//  Den
//
//  Created by Garrett Johnson on 11/13/22.
//  Copyright © 2022 Garrett Johnson. All rights reserved.
//

import SwiftUI

struct FeedBottomBarContent: ToolbarContent {
    @Environment(\.persistentContainer) private var container
    
    @ObservedObject var feed: Feed
    
    @Binding var hideRead: Bool
    @Binding var refreshing: Bool
    
    @State var unreadCount: Int
    @State private var toggling: Bool = false

    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            FilterReadButtonView(hideRead: $hideRead, refreshing: $refreshing)
            Spacer()
            Text("\(unreadCount) Unread")
                .font(.caption)
                .fixedSize()
                .onReceive(
                    NotificationCenter.default.publisher(for: .itemStatus, object: nil)
                ) { notification in
                    guard
                        let feedObjectID = notification.userInfo?["feedObjectID"] as? NSManagedObjectID,
                        feedObjectID == feed.objectID,
                        let read = notification.userInfo?["read"] as? Bool
                    else {
                        return
                    }
                    unreadCount += read ? -1 : 1
                }
                .onReceive(
                    NotificationCenter.default.publisher(for: .feedRefreshed, object: feed.objectID)
                ) { _ in
                    unreadCount = feed.feedData?.previewItems.count ?? 0
                }
            Spacer()
            ToggleReadButtonView(unreadCount: $unreadCount, refreshing: $refreshing) {
                await SyncUtility.toggleReadUnread(
                    container: container,
                    items: feed.feedData?.previewItems ?? []
                )
                feed.objectWillChange.send()
            }
        }
    }
}
