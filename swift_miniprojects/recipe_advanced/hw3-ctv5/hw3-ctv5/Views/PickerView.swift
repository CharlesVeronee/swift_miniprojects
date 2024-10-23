import Foundation
import SwiftUI
import SwiftData

struct PickerView: View {
    @Binding var scaleFactor: Double
    var body: some View {
        Picker("Scale the recipe", selection: $scaleFactor) {
            Text("0.5").tag(0.5)
            Text("1").tag(1.0)
            Text("2").tag(2.0)
        }
        .pickerStyle(.menu)
    }
}
