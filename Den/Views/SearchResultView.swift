//
//  SearchResultView.swift
//  Den
//
//  Created by Garrett Johnson on 9/6/20.
//  Copyright © 2020 Garrett Johnson. All rights reserved.
//

import SwiftUI
import URLImage

struct SearchResultView: View {
    var items: [Item]
    var feed: Feed {
        items.first!.feed!
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                if feed.favicon != nil {
                    URLImage(
                        feed.favicon!,
                        //processors: [ Resize(size: CGSize(width: 16, height: 16), scale: UIScreen.main.scale) ],
                        placeholder: { _ in
                            Image("RSSIcon").faviconView()
                        },
                        failure: { _ in
                            Image("RSSIcon").faviconView()
                        },
                        content: {
                            $0.image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 16, height: 16)
                                .clipped()
                            
                        }
                    )
                    .frame(width: 16, height: 16)
                    .clipped()
                    .accessibility(label: Text("Favicon"))
                }
                Text(feed.wrappedTitle).font(.headline).lineLimit(1)
                Spacer()
            }.padding(.horizontal, 12).padding(.vertical, 8)

            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    ForEach(items.prefix(Int(feed.itemLimit))) { item in
                        Group {
                            Divider()
                            FeedItemView(item: item)
                        }
                    }
                }
                .drawingGroup()
            }
        }
        .background(Color(.systemBackground))
        .cornerRadius(8)
    }
}