//
//  ItemCompactView.swift
//  Den
//
//  Created by Garrett Johnson on 6/29/20.
//  Copyright © 2020 Garrett Johnson
//
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ItemCompactView: View {
    @ObservedObject var item: Item

    var body: some View {
        ItemActionView(item: item) {
            HStack(alignment: .top, spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.wrappedTitle).font(.headline).lineLimit(6)
                    ItemDateAuthorView(item: item)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .multilineTextAlignment(.leading)

                if item.feedData?.feed?.showThumbnails == true {
                    ThumbnailView(item: item).opacity(item.read ? AppDefaults.dimmedImageOpacity : 1.0)
                }
            }
            .padding(8)
        }
        .accessibilityIdentifier("gadget-item-button")
    }
}