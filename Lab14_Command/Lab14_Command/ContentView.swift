import SwiftUI

// Протокол команди
protocol Command {
    var info: String { get }
    func execute()
}

// Команда для вивчення датської мови
class LearnDanishCommand: Command {
    var info: String { return "Вивчити датську мову" }
    func execute() {
        // Реалізація функціоналу для вивчення датської мови
        print("Ви обрали вивчення датської мови")
    }
}

// Команда для практики датської мови
class PracticeDanishCommand: Command {
    var info: String { return "Практикувати датську мову" }
    func execute() {
        // Реалізація функціоналу для практики датської мови
        print("Ви обрали практику датської мови")
    }
}

// Допоміжна структура для ідентифікації команд
struct CommandIdentifier: Identifiable {
    let id = UUID()
    let command: Command
}

// Головний вигляд, що містить меню
struct ContentView: View {
    let learnCommand = LearnDanishCommand()
    let practiceCommand = PracticeDanishCommand()
    @State private var selectedCommand: CommandIdentifier?
    
    var body: some View {
        VStack {
            CommandButton(command: learnCommand, onSelect: { self.selectedCommand = CommandIdentifier(command: self.learnCommand) })
            CommandButton(command: practiceCommand, onSelect: { self.selectedCommand = CommandIdentifier(command: self.practiceCommand) })
        }
        .sheet(item: $selectedCommand) { commandIdentifier in
            DetailView(text: commandIdentifier.command.info, onClose: { self.selectedCommand = nil })
        }
        .frame(width: 200, height: 200) // Додано рамку для візуального зручності у прев'ю
    }
}

// Відображення вікна з текстом після натискання кнопки
struct DetailView: View {
    let text: String
    let onClose: () -> Void
    
    var body: some View {
        VStack {
            Text(text)
                .padding()
            Button("Закрити") {
                self.onClose()
            }
            .padding()
        }
        .frame(width: 200, height: 200) // Додано рамку для візуального зручності у прев'ю
    }
}

// Створення кнопки для команди
struct CommandButton: View {
    let command: Command
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: {
            self.onSelect()
        }) {
            Text(command.info)
        }
        .padding()
    }
}

// Запуск додатка
@main
struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
