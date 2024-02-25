import SwiftUI

// Структура товару
struct Product {
    let id: Int
    let name: String
    let price: Double
}

// Структура балансу користувача
struct UserBalance {
    var amount: Double = 1000.00 // Початковий баланс
}

// Функція для створення трьох товарів
func createProducts() -> [Product] {
    let product1 = Product(id: 1, name: "Сarhartt t-shirt", price: 45.99)
    let product2 = Product(id: 2, name: "Carhartt pants", price: 69.99)
    let product3 = Product(id: 3, name: "Carhartt hoodie", price: 72.00)
    
    return [product1, product2, product3]
}

// Протокол для обробників замовлень
protocol OrderHandler {
    var nextHandler: OrderHandler? { get set }
    func handleOrder(order: Order)
}

// Клас замовлення
struct Order {
    let id: Int
    let amount: Double
}

// Клас обробника замовлення - перевірка на наявність на складі
class StockChecker: OrderHandler {
    var nextHandler: OrderHandler?
    
    func handleOrder(order: Order) {
        if checkStock(for: order) {
            print("Замовлення \(order.id) можна обробити. Перевірка наявності на складі пройшла успішно.")
            nextHandler?.handleOrder(order: order)
        } else {
            print("Замовлення \(order.id) не може бути оброблене через відсутність товару на складі.")
        }
    }
    
    func checkStock(for order: Order) -> Bool {
        // Логіка перевірки наявності товару на складі
        return true // Повертаємо true для спрощення
    }
}

// Клас обробника замовлення - оброблення платежу
class PaymentProcessor: OrderHandler {
    var nextHandler: OrderHandler?
    var userBalance: UserBalance
    
    init(userBalance: UserBalance) {
        self.userBalance = userBalance
    }
    
    func handleOrder(order: Order) {
        if processPayment(for: order) {
            print("Платіж за замовлення \(order.id) успішно оброблено.")
            nextHandler?.handleOrder(order: order)
        } else {
            print("Недостатньо коштів на рахунку для здійснення платежу за замовлення \(order.id).")
        }
    }
    
    func processPayment(for order: Order) -> Bool {
        // Перевіряємо, чи є достатньо коштів на рахунку користувача для оплати замовлення
        if userBalance.amount >= order.amount {
            userBalance.amount -= order.amount // Зменшуємо баланс на суму замовлення
            return true
        } else {
            return false
        }
    }
}

// Клас обробника замовлення - відправка замовлення
class OrderShipper: OrderHandler {
    var nextHandler: OrderHandler?
    
    func handleOrder(order: Order) {
        shipOrder(order)
        print("Замовлення \(order.id) успішно відправлено.")
        // Жоден наступний обробник не використовується, тому не викликаємо nextHandler?.handleOrder(order: order)
    }
    
    func shipOrder(_ order: Order) {
        // Логіка відправки замовлення
    }
}

// Клас, що керує ланцюжком обов'язків
class OrderProcessor {
    private let orderHandler: OrderHandler
    
    init(userBalance: UserBalance) {
        // Створюємо ланцюжок обов'язків
        let stockChecker = StockChecker()
        let paymentProcessor = PaymentProcessor(userBalance: userBalance)
        let orderShipper = OrderShipper()
        
        // Встановлюємо порядок обробників
        stockChecker.nextHandler = paymentProcessor
        paymentProcessor.nextHandler = orderShipper
        
        // Вказуємо початковий обробник
        orderHandler = stockChecker
    }
    
    func processOrder(order: Order) {
        orderHandler.handleOrder(order: order)
    }
}

// SwiftUI view для тестування
struct ContentView: View {
    @State private var userBalance: UserBalance
    var orderProcessor: OrderProcessor
    let products: [Product]
    @State private var showAlert = false // Змінна для відображення спливаючого повідомлення
    
    init(userBalance: UserBalance) {
        self._userBalance = State(initialValue: userBalance)
        self.orderProcessor = OrderProcessor(userBalance: userBalance)
        self.products = createProducts()
    }
    
    var body: some View {
        VStack {
            Text("Баланс: \(userBalance.amount)")
                .padding()
            
            ForEach(products, id: \.id) { product in
                Button(action: {
                    if userBalance.amount >= product.price {
                        let order = Order(id: product.id, amount: product.price)
                        self.orderProcessor.processOrder(order: order)
                        self.userBalance = UserBalance(amount: self.userBalance.amount - product.price)
                    } else {
                        // Відображаємо спливаюче повідомлення про недостатність коштів
                        showAlert = true
                    }
                }) {
                    Text("Купити \(product.name) за \(product.price)")
                }
                .padding()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Недостатньо коштів"), message: Text("Купівля продукту неможлива через недостатній баланс."), dismissButton: .default(Text("OK")))
        }
    }
}

// Запуск програми
@main
struct Chain_of_resposibilityApp: App {
    @State private var userBalance = UserBalance()
    
    var body: some Scene {
        WindowGroup {
            let contentView = ContentView(userBalance: userBalance)
            contentView
        }
    }
}
