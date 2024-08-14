import SwiftUI

@main
struct MedgeGlow: App {
   @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
   
   var body: some Scene {
      WindowGroup {
         ContentView()
            .environmentObject(appDelegate.settings)
      }
   }
}
