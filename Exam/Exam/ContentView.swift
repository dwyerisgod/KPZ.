import SwiftUI

// Клас, що представляє рибку
class Fish: ObservableObject, NSCopying {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    // Метод копіювання
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Fish(name: self.name)
        return copy
    }
}

// Головний клас для керування акваріумом
class AquariumManager: ObservableObject {
    @Published var fishes: [Fish] = []
    
    // Метод для додавання нової рибки
    func addFish(_ fish: Fish) {
        // Клонування прототипу рибки
        let newFish = fish.copy() as! Fish
        fishes.append(newFish)
    }
}

// Приклад використання
struct ContentView: View {
    @ObservedObject var aquariumManager = AquariumManager()
    
    var body: some View {
        VStack {
            Button("Додати рибку") {
                let prototypeFish = Fish(name: "Золота рибка")
                aquariumManager.addFish(prototypeFish)
            }
            
            List(aquariumManager.fishes, id: \.name) { fish in
                Text(fish.name)
            }
        }
    }
}

@main
struct AquariumApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
