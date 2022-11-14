//
//  FeedTitleButtonStyle.swift
//  Den
//
//  Created by Garrett Johnson on 11/12/21.
//  Copyright © 2021 Garrett Johnson. All rights reserved.
//

import SwiftUI

struct FeedTitleButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    @State private var hovering: Bool = false

    var backgroundColor: Color = Color.clear

    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        configuration.label
            .font(.title3)
            .foregroundColor(
                isEnabled ? .primary : .secondary
            )
            .frame(height: 40)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                backgroundColor.overlay {
                    isEnabled ?
                        hovering ? Color(UIColor.quaternarySystemFill) : .clear
                    : .clear
                }
            )
            .onHover { hovered in
                hovering = hovered
            }
            .onDisappear {
                hovering = false
            }
    }
}