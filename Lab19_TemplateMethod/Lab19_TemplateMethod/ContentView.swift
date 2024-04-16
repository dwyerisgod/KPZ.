import SwiftUI

// Базовий клас для робітників
class Worker {
    // Шаблонний метод, який визначає загальну структуру робочого дня
    func workDaySchedule() {
        startWorking()
        continueWorking()
        finishWorking()
    }

    // Абстрактні методи, які потрібно перевизначити у підкласах
    func startWorking() {
        fatalError("Method must be overridden")
    }

    func continueWorking() {
        fatalError("Method must be overridden")
    }

    func finishWorking() {
        fatalError("Method must be overridden")
    }
}

// Поштар
class Postman: Worker {
    override func startWorking() {
        print("Поштар виходить на роботу")
    }

    override func continueWorking() {
        print("Поштар роздає пошту")
    }

    override func finishWorking() {
        print("Поштар завершує робочий день")
    }
}

// Пожежник
class Firefighter: Worker {
    override func startWorking() {
        print("Пожежник готує обладнання для виїзду")
    }

    override func continueWorking() {
        print("Пожежник гасить пожежі")
    }

    override func finishWorking() {
        print("Пожежник повертається на базу")
    }
}

// Продавець
class Salesperson: Worker {
    override func startWorking() {
        print("Продавець відкриває магазин")
    }

    override func continueWorking() {
        print("Продавець обслуговує покупців")
    }

    override func finishWorking() {
        print("Продавець закриває магазин")
    }
}

// Менеджер
class Manager: Worker {
    override func startWorking() {
        print("Менеджер проводить зустрічі")
    }

    override func continueWorking() {
        print("Менеджер контролює виконання завдань")
    }

    override func finishWorking() {
        print("Менеджер аналізує результати роботи")
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Розклад поштаря") {
                let postman = Postman()
                postman.workDaySchedule()
            }

            Button("Розклад пожежника") {
                let firefighter = Firefighter()
                firefighter.workDaySchedule()
            }

            Button("Розклад продавця") {
                let salesperson = Salesperson()
                salesperson.workDaySchedule()
            }

            Button("Розклад менеджера") {
                let manager = Manager()
                manager.workDaySchedule()
            }
        }
        .padding()
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
