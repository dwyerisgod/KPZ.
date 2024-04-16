import SwiftUI

// Базовий клас для студентів
class Student {
    let name: String
    var gpa: Double

    init(name: String, gpa: Double) {
        self.name = name
        self.gpa = gpa
    }

    // Метод для прийняття відвідувача
    func accept(visitor: Visitor) {
        fatalError("Method must be overridden")
    }
}

// Конкретний клас для студента бакалавра
class UndergraduateStudent: Student {
    override func accept(visitor: Visitor) {
        visitor.visit(undergraduateStudent: self)
    }
}

// Конкретний клас для студента магістра
class GraduateStudent: Student {
    override func accept(visitor: Visitor) {
        visitor.visit(graduateStudent: self)
    }
}

// Протокол для відвідувача
protocol Visitor {
    func visit(undergraduateStudent: UndergraduateStudent)
    func visit(graduateStudent: GraduateStudent)
}

// Конкретний відвідувач, який визначає, чи студент отримує президентську стипендію
class PresidentialScholarshipVisitor: Visitor {
    func visit(undergraduateStudent: UndergraduateStudent) {
        if undergraduateStudent.gpa >= 3.8 {
            print("\(undergraduateStudent.name) отримує президентську стипендію!")
        } else {
            print("\(undergraduateStudent.name) не отримує президентську стипендію.")
        }
    }

    func visit(graduateStudent: GraduateStudent) {
        if graduateStudent.gpa >= 3.9 {
            print("\(graduateStudent.name) отримує президентську стипендію!")
        } else {
            print("\(graduateStudent.name) не отримує президентську стипендію.")
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Перевірити стипендію бакалавра") {
                let undergraduateStudent = UndergraduateStudent(name: "Іван", gpa: 3.9)
                let visitor = PresidentialScholarshipVisitor()
                undergraduateStudent.accept(visitor: visitor)
            }

            Button("Перевірити стипендію магістра") {
                let graduateStudent = GraduateStudent(name: "Марія", gpa: 3.85)
                let visitor = PresidentialScholarshipVisitor()
                graduateStudent.accept(visitor: visitor)
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
