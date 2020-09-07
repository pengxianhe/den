//
//  PageListRowView.swift
//  Den
//
//  Created by Garrett Johnson on 6/29/20.
//  Copyright © 2020 Garrett Johnson. All rights reserved.
//

import SwiftUI

/**
 Page list item view. Transforms name text labels into text fields when .editMode is active.
 */
struct PageListRowView: View {
    @EnvironmentObject var screenManager: ScreenManager
    @ObservedObject var page: Page
    
    var body: some View {
        Group {
            if page.id != nil {
                NavigationLink(destination: PageView(page: page), tag: page.id!.uuidString, selection: $screenManager.activeScreen) {
                    HStack {
                        Image(systemName: "square.grid.2x2").resizable().scaledToFit().frame(width: 18, height: 18).padding(.trailing, 2)
                        Text(page.wrappedName).fontWeight(.medium).lineLimit(1).multilineTextAlignment(.leading)
                        Spacer()
                        Text(String(page.unreadCount))
                            .font(.caption)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(
                                Capsule(style: .circular).foregroundColor(Color(UIColor.secondarySystemBackground)
                            )
                        ).accessibility(value: Text("\(page.wrappedName): \(page.unreadCount) unread"))
                    }
                }.frame(height: 44)
            }
        }
    }
}
