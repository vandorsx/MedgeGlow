import Cocoa
import SwiftUI

class PreferencesWindowController: NSWindowController {
   convenience init(settings: OverlaySettings) {
      let contentView = ContentView().environmentObject(settings)
      let hostingController = NSHostingController(rootView: contentView)
      let window = NSWindow(contentViewController: hostingController)
      window.title = "Preferences"
      window.setContentSize(NSSize(width: 300, height: 200))
      self.init(window: window)
   }
}
