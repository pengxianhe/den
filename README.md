# Den for RSS

Den is a start-page app for creating dashboards with feeds from your favorite websites.

It's designed to be a simple way to catch up on what's happening without all the extras. It's about browsing the latest headlines without being interupted by ads or distracted by the latest social media hooks. It enables one to create as many pages as they like, containing as many feeds as desired, for following anything they want.

Features

- Compatible with iPhone, iPad, and Mac
- No extra website account or registration required
- Subscriptions and history synchronizes across devices with iCloud
- Compatible with RSS, Atom, and JSON feed formats
- Global search for filtering current items by keyword
- OPML import and export for sharing subscriptions
- Light and dark theme options
- History view with search for finding previously visited links
- Native app engineered for speed and efficiency


## Release Notes

### Den v1.5

Version 1.5 adds page icon customization.

- Page icon picker with over 300 symbols
- Fixed bug that prevented moving feeds between pages
- Minor interface and performance improvements

### Den v1.4

Version 1.4 enables viewing and managing visited links (history).

- Tab bar for top level views
- History view with search
- Several general bug fixes and improvements

### Den v1.3

Version 1.3 contains several major application performance improvements and many minor user interface enhancements.

- Data is now stored in two databases; one local and one cloud synced. Feed content is kept local, while subscriptions and history are stored in the cloud. Cloud sync may still be disabled in iCloud preferences and the app will work entirely with local databases.
- Images are now downloaded, resized, and saved to locally during feed refresh. The result is better performance and lower memory usage, especially on Mac where a lot images can be in view at once.
- Fixed UI bug that caused dialog boxes to close randomly.
- Fixed UI bug that caused dialog boxes to ignore dark/light mode setting.
- Various other bug fixes, performance improvements, and usability enhancements.

## Technical Documentation

### Foundations

Den is a UIKit application written in Swift and SwiftUI with a good deal of work put towards creating a native experience on MacOS via Catalyst. The major core framework dependencies are Core Data, CloudKit, and Safari Services. Xcode is the only development dependency.

### Open Source Dependencies

- [AEXML](https://github.com/tadija/AEXML) is used for reading and writing OPML files
- [FeedKit](https://github.com/nmdias/FeedKit) for parsing feeds into Swift objects
- [Grid](https://github.com/spacenation/swiftui-grid) for staggard display of widgets (search view)
- [HTMLEntities](https://github.com/Kitura/swift-html-entities) for unescaping `&blah;` in titles and summaries
- [SwiftSoup](https://github.com/scinfu/SwiftSoup) for parsing and cleaning HTML (used to find favicons, preview images, etc.)

### Repository Layout

* `Documents` Design files
* `Den` Main source directory
  * `Entities` Classes for Core Data entities and collections
  * `Models` Data objects and view models
  * `Managers` Global service managers provided to views via `.environmentObject()`
  * `Operations` Classes used to build workflows for `OperationQueue()` (ex. feed ingest)
  * `Views` SwiftUI interface declarations
  * `Extensions` Various patches to core and vendor classes
  * `Utilities` Helper classes for OPML I/0, text transformation, etc.
  * `Misc` Misc artifacts (file type icons, demo feeds)
* `DenTests` TODO
* `DenUITests` TODO
* `DenScreenshots` UI Tests for generating App Store screenshots


## Developer Setup

### Requirements

1. Xcode with Command Line Tools
2. [xcparse](https://github.com/ChargePoint/xcparse) to extract screenshots from test results `brew install chargepoint/xcparse/xcparse`

---

Copyright 2020 Garrett Johnson. All Rights Reserved.
