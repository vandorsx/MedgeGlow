import SwiftUI

class OverlaySettings: ObservableObject {
   @Published var red: Double {
      didSet { UserDefaults.standard.set(red, forKey: "overlayColorRed") }
   }
   @Published var green: Double {
      didSet { UserDefaults.standard.set(green, forKey: "overlayColorGreen") }
   }
   @Published var blue: Double {
      didSet { UserDefaults.standard.set(blue, forKey: "overlayColorBlue") }
   }
   @Published var distance: Double {
      didSet { UserDefaults.standard.set(distance, forKey: "distance") }
   }
   @Published var fade: Double {
      didSet { UserDefaults.standard.set(fade, forKey: "fade") }
   }
   
   init() {
      self.red = UserDefaults.standard.double(forKey: "overlayColorRed")
      self.green = UserDefaults.standard.double(forKey: "overlayColorGreen")
      self.blue = UserDefaults.standard.double(forKey: "overlayColorBlue")
      self.distance = UserDefaults.standard.double(forKey: "distance")
      self.fade = UserDefaults.standard.double(forKey: "fade")
      
      // Set default values if not already set
      if self.red == 0 && self.green == 0 && self.blue == 0 {
         self.red = 1.0
         self.green = 0.0
         self.blue = 0.0
      }
      if self.distance == 0 {
         self.distance = 50
      }
      if self.fade == 0 {
         self.fade = 0.5
      }
   }
}
