import SwiftUI

struct TransparentWindow: NSViewRepresentable {
   func makeNSView(context: Context) -> NSView {
      let view = NSView()
      DispatchQueue.main.async {
         if let window = view.window {
            window.backgroundColor = .clear
            window.isOpaque = false
            window.level = .screenSaver
            window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
         }
      }
      return view
   }
   
   func updateNSView(_ nsView: NSView, context: Context) {}
}

struct OverlayView: View {
   @EnvironmentObject var settings: OverlaySettings
   
   private var overlayColor: Color {
      Color(red: settings.red, green: settings.green, blue: settings.blue, opacity: settings.alpha)
   }
   
   var body: some View {
      ZStack {
         TransparentWindow()
         
         GeometryReader { geometry in
            ZStack {
               Color.clear
               
               EdgeOverlay(
                  color: overlayColor,
                  fade: settings.fade,
                  distance: settings.distance,
                  gradientStartPoint: .top,
                  gradientEndPoint: .bottom,
                  offset: CGSize(width: 0, height: -geometry.size.height / 2 + CGFloat(settings.distance) / 2)
               )
               
               EdgeOverlay(
                  color: overlayColor,
                  fade: settings.fade,
                  distance: settings.distance,
                  gradientStartPoint: .bottom,
                  gradientEndPoint: .top,
                  offset: CGSize(width: 0, height: geometry.size.height / 2 - CGFloat(settings.distance) / 2)
               )
               
               EdgeOverlay(
                  color: overlayColor,
                  fade: settings.fade,
                  distance: settings.distance,
                  gradientStartPoint: .leading,
                  gradientEndPoint: .trailing,
                  offset: CGSize(width: -geometry.size.width / 2 + CGFloat(settings.distance) / 2, height: 0)
               )
               
               EdgeOverlay(
                  color: overlayColor,
                  fade: settings.fade,
                  distance: settings.distance,
                  gradientStartPoint: .trailing,
                  gradientEndPoint: .leading,
                  offset: CGSize(width: geometry.size.width / 2 - CGFloat(settings.distance) / 2, height: 0)
               )
            }
         }
      }
      .ignoresSafeArea()
   }
}

struct EdgeOverlay: View {
   var color: Color
   var fade: Double
   var distance: Double
   var gradientStartPoint: UnitPoint
   var gradientEndPoint: UnitPoint
   var offset: CGSize
   
   var body: some View {
      LinearGradient(
         gradient: Gradient(colors: [color, Color.clear]),
         startPoint: gradientStartPoint,
         endPoint: gradientEndPoint
      )
      .frame(width: gradientStartPoint == .leading || gradientStartPoint == .trailing ? CGFloat(distance) : nil,
             height: gradientStartPoint == .top || gradientStartPoint == .bottom ? CGFloat(distance) : nil)
      .opacity(fade)
      .offset(offset)
   }
}
