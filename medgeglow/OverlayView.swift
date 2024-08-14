import SwiftUI

struct OverlayView: View {
   @AppStorage("overlayColorRed") private var red: Double = 1.0
   @AppStorage("overlayColorGreen") private var green: Double = 0.0
   @AppStorage("overlayColorBlue") private var blue: Double = 0.0
   @AppStorage("distance") private var distance: Double = 50
   @AppStorage("fade") private var fade: Double = 0.5
   
   private var overlayColor: Color {
      Color(red: red, green: green, blue: blue)
   }
   
   var body: some View {
      GeometryReader { geometry in
         ZStack {
            Color.clear
            
            // Top edge
            LinearGradient(gradient: Gradient(colors: [overlayColor, Color.clear]),
                           startPoint: .top,
                           endPoint: .bottom)
            .frame(height: CGFloat(distance))
            .opacity(fade)
            .offset(y: -geometry.size.height / 2 + CGFloat(distance) / 2)
            
            // Bottom edge
            LinearGradient(gradient: Gradient(colors: [overlayColor, Color.clear]),
                           startPoint: .bottom,
                           endPoint: .top)
            .frame(height: CGFloat(distance))
            .opacity(fade)
            .offset(y: geometry.size.height / 2 - CGFloat(distance) / 2)
            
            // Left edge
            LinearGradient(gradient: Gradient(colors: [overlayColor, Color.clear]),
                           startPoint: .leading,
                           endPoint: .trailing)
            .frame(width: CGFloat(distance))
            .opacity(fade)
            .offset(x: -geometry.size.width / 2 + CGFloat(distance) / 2)
            
            // Right edge
            LinearGradient(gradient: Gradient(colors: [overlayColor, Color.clear]),
                           startPoint: .trailing,
                           endPoint: .leading)
            .frame(width: CGFloat(distance))
            .opacity(fade)
            .offset(x: geometry.size.width / 2 - CGFloat(distance) / 2)
         }
      }
      .ignoresSafeArea()
   }
}
