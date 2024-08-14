import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
   var statusItem: NSStatusItem?
   var overlayWindow: NSWindow?
   let settings = OverlaySettings()
   var preferencesWindowController: PreferencesWindowController?
   
   func applicationDidFinishLaunching(_ notification: Notification) {
      setupStatusItem()
      setupOverlayWindow()
      setupPreferencesWindow()
      
      NSApplication.shared.mainMenu = buildMenu()
   }
   
   func setupPreferencesWindow() {
      preferencesWindowController = PreferencesWindowController(settings: settings)
   }
   
   @objc func showPreferences() {
      preferencesWindowController?.showWindow(nil)
   }
   
   
   func setupStatusItem() {
      statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
      if let button = statusItem?.button {
         button.image = NSImage(systemSymbolName: "rectangle.inset.filled", accessibilityDescription: nil)
         button.action = #selector(toggleOverlay)
      }
   }
   
   @objc func toggleMenu() {
      if statusItem?.menu == nil {
         statusItem?.menu = createMenu()
      } else {
         statusItem?.menu = nil
      }
      
      statusItem?.button?.performClick(nil)
   }
   
   func createMenu() -> NSMenu {
      let menu = NSMenu()
      
      menu.addItem(NSMenuItem(title: "Toggle Overlay", action: #selector(toggleOverlay), keyEquivalent: ""))
      menu.addItem(NSMenuItem(title: "Preferences...", action: #selector(showPreferences), keyEquivalent: ","))
      menu.addItem(NSMenuItem.separator())
      menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
      
      return menu
   }
   
   @objc func toggleOverlay() {
      if overlayWindow?.isVisible == true {
         overlayWindow?.orderOut(nil)
      } else {
         overlayWindow?.makeKeyAndOrderFront(nil)
      }
   }
   
   func setupOverlayWindow() {
      let screen = NSScreen.main ?? NSScreen.screens[0]
      let frame = NSRect(x: 0, y: 0, width: screen.frame.width, height: screen.frame.height)
      
      overlayWindow = NSWindow(contentRect: frame, styleMask: [.borderless], backing: .buffered, defer: false, screen: screen)
      overlayWindow?.level = .screenSaver
      overlayWindow?.isOpaque = false
      overlayWindow?.backgroundColor = .clear
      overlayWindow?.ignoresMouseEvents = true
      
      let hostingView = NSHostingView(rootView:
                                       OverlayView()
         .environmentObject(settings)
      )
      overlayWindow?.contentView = hostingView
      overlayWindow?.makeKeyAndOrderFront(nil)
   }
   
   func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
      return false
   }
}

extension AppDelegate {
   func buildMenu() -> NSMenu {
      let mainMenu = NSMenu()
      
      let appMenuItem = NSMenuItem()
      appMenuItem.submenu = NSMenu(title: "App")
      mainMenu.addItem(appMenuItem)
      
      let appMenu = appMenuItem.submenu!
      appMenu.addItem(NSMenuItem(title: "About MedgeGlow", action: #selector(NSApplication.orderFrontStandardAboutPanel(_:)), keyEquivalent: ""))
      appMenu.addItem(NSMenuItem.separator())
      appMenu.addItem(NSMenuItem(title: "Settings...", action: #selector(showPreferences), keyEquivalent: ","))
      appMenu.addItem(NSMenuItem.separator())
      appMenu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
      
      return mainMenu
   }
}
