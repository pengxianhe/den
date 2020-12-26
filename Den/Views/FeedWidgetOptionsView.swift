//
//  FeedEditView.swift
//  Den
//
//  Created by Garrett Johnson on 5/23/20.
//  Copyright © 2020 Garrett Johnson. All rights reserved.
//

import Foundation
import SwiftUI

/**
 FeedOptionsView wrapper for displaying options in a modal sheet.
 */
struct FeedWidgetOptionsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var feed: Feed    
    
    var body: some View {
        NavigationView {
            FeedOptionsFormView(
                feed: feed,
                onDelete: close,
                onMove: close
            )
            .navigationBarTitle("Feed Options", displayMode: .inline)
            .navigationBarItems(leading: Button(action: close) { Text("Close") })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func close() {
        presentationMode.wrappedValue.dismiss()
    }
}