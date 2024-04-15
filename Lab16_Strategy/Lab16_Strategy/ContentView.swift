import SwiftUI

// Протокол стратегії для формування кошторису
protocol BudgetStrategy {
    func estimateCost() -> String
}

// Бюджетний варіант
class BudgetOption: BudgetStrategy {
    func estimateCost() -> String {
        return "Бюджетний варіант: $100,000"
    }
}

// Якість/ціна
class QualityPriceOption: BudgetStrategy {
    func estimateCost() -> String {
        return "Якість/ціна: $200,000"
    }
}

// Дорогий будинок
class ExpensiveOption: BudgetStrategy {
    func estimateCost() -> String {
        return "Дорогий будинок: $500,000"
    }
}

// Клас для побудови будинку з використанням патерну стратегія
class HouseBuilder {
    var budgetStrategy: BudgetStrategy

    init(budgetStrategy: BudgetStrategy) {
        self.budgetStrategy = budgetStrategy
    }

    func estimateCost() -> String {
        return budgetStrategy.estimateCost()
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Виберіть фінансові можливості замовника:")
                .padding()
            
            Button(action: {
                let builder = HouseBuilder(budgetStrategy: BudgetOption())
                print(builder.estimateCost()) // Виведе: "Бюджетний варіант: $100,000"
            }) {
                Text("Бюджетний варіант")
            }
            .padding()
            
            Button(action: {
                let builder = HouseBuilder(budgetStrategy: QualityPriceOption())
                print(builder.estimateCost()) // Виведе: "Якість/ціна: $200,000"
            }) {
                Text("Якість/ціна")
            }
            .padding()
            
            Button(action: {
                let builder = HouseBuilder(budgetStrategy: ExpensiveOption())
                print(builder.estimateCost()) // Виведе: "Дорогий будинок: $500,000"
            }) {
                Text("Дорогий будинок")
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
