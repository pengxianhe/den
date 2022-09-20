//
//  ItemPreviewView.swift
//  Den
//
//  Created by Garrett Johnson on 12/10/21.
//  Copyright © 2021 Garrett Johnson. All rights reserved.
//

import SwiftUI

struct ItemPreviewView: View {
    @Environment(\.isEnabled) private var isEnabled

    @ObservedObject var item: Item

    var hasTeaser: Bool {
        item.teaser != nil && item.teaser != ""
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(item.wrappedTitle)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .topLeading)

            ItemDateView(date: item.date, read: item.read)

            if item.feedData?.feed?.showThumbnails == true && item.image != nil {
                PreviewImageView(item: item)
                    .padding(.top, 4)
                    .padding(.bottom, hasTeaser ? 4 : 0)
                    .opacity(item.read ? UIConstants.dimmedImageOpacity : 1.0)
            }

            if hasTeaser {
                Text(item.teaser!).font(.body).lineLimit(6)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(12)
        .multilineTextAlignment(.leading)
        .foregroundColor(
            isEnabled ?
                item.read ? .secondary : .primary
            :
                item.read ? Color(UIColor.quaternaryLabel) : Color(UIColor.tertiaryLabel)
        )
        .frame(maxWidth: .infinity)
    }
}