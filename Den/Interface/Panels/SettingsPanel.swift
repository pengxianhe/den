//
//  SettingsPanel.swift
//  Den
//
//  Created by Garrett Johnson on 12/31/22.
//  Copyright © 2022 Garrett Johnson
//
//  SPDX-License-Identifier: MIT
//

import Foundation

enum SettingsPanel: Hashable {
    case profileSettings(Profile)
    case importFeeds
    case exportFeeds
    case security
}
