import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
   var statusItem: NSStatusItem?
   var overlayWindow: NSWindow?
   
   func applicationDidFinishLaunching(_ notification: Notification) {
      statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
      if let button = statusItem?.button {
         button.image = NSImage(systemSymbolName: "rectangle.inset.filled", accessibilityDescription: nil)
      }
      
      setupOverlayWindow()
   }
   
   func setupOverlayWindow() {
      let screen = NSScreen.main ?? NSScreen.screens[0]
      let frame = NSRect(x: 0, y: 0, width: screen.frame.width, height: screen.frame.height)
      
      overlayWindow = NSWindow(contentRect: frame, styleMask: [.borderless], backing: .buffered, defer: false, screen: screen)
      overlayWindow?.level = .screenSaver
      overlayWindow?.isOpaque = false
      overlayWindow?.backgroundColor = .clear
      overlayWindow?.ignoresMouseEvents = true
      
      let hostingView = NSHostingView(rootView: OverlayView())
      overlayWindow?.contentView = hostingView
      overlayWindow?.makeKeyAndOrderFront(nil)
   }
}
