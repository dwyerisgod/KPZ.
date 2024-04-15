import SwiftUI
import Combine

// Протокол для збереження та відновлення стану
protocol Memento {
    var state: String { get }
}

// Знімок стану графічного об'єкту
class GraphicObjectMemento: Memento {
    var state: String

    init(state: String) {
        self.state = state
    }
}

// Графічний об'єкт
class GraphicObject: ObservableObject {
    @Published var path: String

    init(path: String) {
        self.path = path
    }

    func draw() {
        // Реалізація відображення графічного об'єкту
        print("Drawing graphic object with path: \(path)")
    }

    func save() -> Memento {
        return GraphicObjectMemento(state: path)
    }

    func restore(from memento: Memento) {
        guard let graphicMemento = memento as? GraphicObjectMemento else { return }
        self.path = graphicMemento.state
    }
}

// Зберігач для керування знімками
class Caretaker: ObservableObject {
    @Published var mementos: [Memento] = []

    func addMemento(_ memento: Memento) {
        mementos.append(memento)
    }

    func getMemento(at index: Int) -> Memento? {
        guard index >= 0 && index < mementos.count else { return nil }
        return mementos[index]
    }
}

// Головний віджет
struct ContentView: View {
    @StateObject var caretaker = Caretaker()
    @StateObject var graphicObject = GraphicObject(path: "Initial path")

    var body: some View {
        VStack {
            Button("Draw Object") {
                graphicObject.draw()
            }
            .padding()

            Button("Change Object") {
                graphicObject.path = "New path"
                graphicObject.draw()
                caretaker.addMemento(graphicObject.save())
            }
            .padding()

            Button("Undo Change") {
                if let memento = caretaker.getMemento(at: caretaker.mementos.count - 1) {
                    graphicObject.restore(from: memento)
                    graphicObject.draw()
                    caretaker.mementos.removeLast()
                }
            }
            .padding()
        }
    }
}

@main
struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
