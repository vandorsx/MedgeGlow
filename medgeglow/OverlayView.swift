import SwiftUI

struct OverlayView: View {
   @EnvironmentObject var settings: OverlaySettings
   
   private var overlayColor: Color {
      Color(red: settings.red, green: settings.green, blue: settings.blue)
   }
   
   var body: some View {
      GeometryReader { geometry in
         ZStack {
            Color.clear
            
            // Top edge
            LinearGradient(gradient: Gradient(colors: [overlayColor, Color.clear]),
                           startPoint: .top,
                           endPoint: .bottom)
            .frame(height: CGFloat(settings.distance))
            .opacity(settings.fade)
            .offset(y: -geometry.size.height / 2 + CGFloat(settings.distance) / 2)
            
            // Bottom edge
            LinearGradient(gradient: Gradient(colors: [overlayColor, Color.clear]),
                           startPoint: .bottom,
                           endPoint: .top)
            .frame(height: CGFloat(settings.distance))
            .opacity(settings.fade)
            .offset(y: geometry.size.height / 2 - CGFloat(settings.distance) / 2)
            
            // Left edge
            LinearGradient(gradient: Gradient(colors: [overlayColor, Color.clear]),
                           startPoint: .leading,
                           endPoint: .trailing)
            .frame(width: CGFloat(settings.distance))
            .opacity(settings.fade)
            .offset(x: -geometry.size.width / 2 + CGFloat(settings.distance) / 2)
            
            // Right edge
            LinearGradient(gradient: Gradient(colors: [overlayColor, Color.clear]),
                           startPoint: .trailing,
                           endPoint: .leading)
            .frame(width: CGFloat(settings.distance))
            .opacity(settings.fade)
            .offset(x: geometry.size.width / 2 - CGFloat(settings.distance) / 2)
         }
      }
      .ignoresSafeArea()
   }
}
