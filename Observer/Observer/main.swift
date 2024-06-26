import Foundation

// Протокол спостерігача
protocol ChatObserver: AnyObject {
    var name: String { get }
    func receive(message: String, from user: String)
}

// Клас чату
class Chat {
    private var participants = [ChatObserver]()
    
    // Додати учасника в чат
    func addParticipant(_ participant: ChatObserver) {
        participants.append(participant)
    }
    
    // Надіслати повідомлення вибраним учасникам
    func sendMessage(_ message: String, to participant: ChatObserver, from user: String) {
        participant.receive(message: message, from: user)
    }
}

// Клас учасника чату
class ChatParticipant: ChatObserver {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func receive(message: String, from user: String) {
        print("\(name) отримав(ла) повідомлення від \(user): \(message)")
    }
}

// Приклад використання
let chat = Chat()

let participant1 = ChatParticipant(name: "Олексій")
let participant2 = ChatParticipant(name: "Іван")
let participant3 = ChatParticipant(name: "Марія")

chat.addParticipant(participant1)
chat.addParticipant(participant2)
chat.addParticipant(participant3)

while true {
    // Вибір учасника
    print("Виберіть учасника (Олексій, Іван або Марія):")
    guard let participantName = readLine()?.capitalized else {
        print("Помилка: невідомий учасник")
        continue
    }

    var selectedParticipant: ChatObserver?

    switch participantName {
    case "Олексій":
        selectedParticipant = participant1
    case "Іван":
        selectedParticipant = participant2
    case "Марія":
        selectedParticipant = participant3
    default:
        print("Помилка: невідомий учасник")
        continue
    }

    if let selectedParticipant = selectedParticipant {
        // Введення тексту повідомлення
        print("Введіть текст повідомлення:")
        guard let message = readLine() else {
            print("Помилка: неможливо прочитати повідомлення")
            continue
        }

        let user = "Ви" // Ім'я користувача, який надсилає повідомлення
        
        // Надсилання повідомлення обраному учаснику
        chat.sendMessage(message, to: selectedParticipant, from: user)
        
        // Опція продовження роботи
        print("Бажаєте продовжити роботу? (Так/Ні)")
        let choice = readLine()?.lowercased()
        if choice == "ні" || choice == "no" {
            break
        }
    }
}
