import SwiftUI

struct ContentView: View {
   @EnvironmentObject var settings: OverlaySettings
   
   var body: some View {
      VStack {
         ColorPicker("Overlay Color", selection: Binding(
            get: { Color(red: settings.red, green: settings.green, blue: settings.blue, opacity: settings.alpha) },
            set: { newColor in
               let uiColor = NSColor(newColor)
               settings.red = Double(uiColor.redComponent)
               settings.green = Double(uiColor.greenComponent)
               settings.blue = Double(uiColor.blueComponent)
               settings.alpha = Double(uiColor.alphaComponent)
            }
         ), supportsOpacity: true)
         
         Slider(value: $settings.distance, in: 0...100) {
            Text("Distance: \(Int(settings.distance))")
         }
         
         Slider(value: $settings.fade, in: 0...1) {
            Text("Fade: \(settings.fade, specifier: "%.2f")")
         }
      }
      .padding()
      .frame(width: 300, height: 200)
   }
}
