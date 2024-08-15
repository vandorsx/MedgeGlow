import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
   var statusItem: NSStatusItem?
   var overlayWindow: NSWindow?
   var preferencesWindowController: PreferencesWindowController?
   var popover: NSPopover?
   
   let settings = OverlaySettings()
   
   func applicationDidFinishLaunching(_ notification: Notification) {
      setupUIComponents()
   }
   
   // MARK: - Setup Methods
   
   private func setupUIComponents() {
      setupStatusItem()
      setupOverlayWindow()
      setupPreferencesWindow()
      setupPopover()
   }
   
   private func setupStatusItem() {
      statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
      guard let button = statusItem?.button else { return }
      
      button.image = NSImage(systemSymbolName: "rectangle.inset.filled", accessibilityDescription: nil)
      button.action = #selector(handleStatusItemAction(_:))
      button.sendAction(on: [.leftMouseUp, .rightMouseUp])
   }
   
   private func setupOverlayWindow() {
      let screen = NSScreen.main ?? NSScreen.screens[0]
      let frame = NSRect(x: 0, y: 0, width: screen.frame.width, height: screen.frame.height)
      
      overlayWindow = NSWindow(contentRect: frame, styleMask: [.borderless], backing: .buffered, defer: false, screen: screen)
      overlayWindow?.level = .screenSaver
      overlayWindow?.isOpaque = false
      overlayWindow?.backgroundColor = .clear
      overlayWindow?.ignoresMouseEvents = true
      
      let hostingView = NSHostingView(rootView: OverlayView().environmentObject(settings))
      overlayWindow?.contentView = hostingView
      overlayWindow?.orderFront(nil)
   }
   
   private func setupPreferencesWindow() {
      preferencesWindowController = PreferencesWindowController(settings: settings)
   }
   
   private func setupPopover() {
      popover = NSPopover()
      popover?.contentSize = NSSize(width: 300, height: 200)
      popover?.behavior = .transient
      popover?.contentViewController = NSHostingController(rootView: ContentView().environmentObject(settings))
   }
   
   // MARK: - Menu Actions
   
   @objc private func handleStatusItemAction(_ sender: NSStatusBarButton) {
      guard let event = NSApp.currentEvent else { return }
      
      if event.type == .rightMouseUp {
         showRightClickMenu()
      } else {
         toggleOverlay()
      }
   }
   
   private func showRightClickMenu() {
      let menu = createRightClickMenu()
      statusItem?.menu = menu
      statusItem?.button?.performClick(nil)
      statusItem?.menu = nil
   }
   
   @objc private func togglePopover(_ sender: NSStatusBarButton) {
      guard let event = NSApp.currentEvent else { return }
      
      if event.type == .rightMouseUp {
         showRightClickMenu()
      } else if let popover = popover {
         if popover.isShown {
            popover.performClose(sender)
         } else {
            popover.show(relativeTo: sender.bounds, of: sender, preferredEdge: .minY)
         }
      }
   }
   
   private func updateStatusItemImage(isOverlayVisible: Bool) {
      let imageName = isOverlayVisible ? "rectangle.inset.filled" : "rectangle"
      statusItem?.button?.image = NSImage(systemSymbolName: imageName, accessibilityDescription: nil)
   }
   
   @objc func toggleOverlay() {
      if overlayWindow?.isVisible == true {
         overlayWindow?.orderOut(nil)
         updateStatusItemImage(isOverlayVisible: false)
      } else {
         overlayWindow?.orderFront(nil)
         updateStatusItemImage(isOverlayVisible: true)
      }
   }
   
   @objc private func showPreferences() {
      preferencesWindowController?.showWindow(nil)
   }
   
   @objc private func showAboutPanel() {
      NSApplication.shared.orderFrontStandardAboutPanel(nil)
   }
   
   // MARK: - Menu Creation
   
   private func createRightClickMenu() -> NSMenu {
      let menu = NSMenu()
      menu.addItem(NSMenuItem(title: "Settings...", action: #selector(showPreferences), keyEquivalent: ","))
      menu.addItem(NSMenuItem.separator())
      menu.addItem(NSMenuItem(title: "About MedgeGlow", action: #selector(showAboutPanel), keyEquivalent: ""))
      menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
      return menu
   }
   
   // MARK: - NSApplicationDelegate
   
   func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
      return false
   }
}
