// Протокол для всех элементов комнаты
protocol RoomComponent {
    func display()
}

// Класс для предметов в комнате
class Item: RoomComponent {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func display() {
        print("Item: \(name)")
    }
}

// Класс для предметов в комнате
class Screamer: RoomComponent {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func display() {
        print("Screamer: \(name)")
    }
}

// Класс для комнаты
class Room: RoomComponent {
    var name: String
    var components: [RoomComponent]
    
    init(name: String) {
        self.name = name
        self.components = []
    }
    
    func addComponent(component: RoomComponent) {
        components.append(component)
    }
    
    func display() {
        print("Room: \(name)")
        for component in components {
            component.display()
        }
    }
}

// Пример использования
let room = Room(name: "Quest Room #1")
let chair = Item(name: "Chair")
let table = Item(name: "Table")

let room2 = Room(name: "Quest Room #2")
let bed = Item(name: "Bed")
let lamp = Item(name: "Lamp")
let screamer1 = Screamer(name: "Jason Voorhers")

room.addComponent(component: chair)
room.addComponent(component: table)

room.addComponent(component: room2)
room2.addComponent(component: bed)
room2.addComponent(component: lamp)
room2.addComponent(component: screamer1)

room.display()
