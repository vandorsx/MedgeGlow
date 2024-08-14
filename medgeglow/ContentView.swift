import SwiftUI
import Cocoa

struct ContentView: View {
   @State private var overlayColor = Color.red
   @State private var distance: CGFloat = 50
   @State private var fade: CGFloat = 0.5
   
   var body: some View {
      VStack {
         ColorPicker("Overlay Color", selection: $overlayColor)
         
         Slider(value: $distance, in: 0...100) {
            Text("Distance: \(Int(distance))")
         }
         
         Slider(value: $fade, in: 0...1) {
            Text("Fade: \(fade, specifier: "%.2f")")
         }
      }
      .padding()
      .frame(width: 300, height: 200)
   }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ContentView()
   }
}
