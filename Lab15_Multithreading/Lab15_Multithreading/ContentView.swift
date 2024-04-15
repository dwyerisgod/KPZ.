import SwiftUI

// Завдання №1: Пошук максимуму та мінімуму у масиві з використанням потоків
class MaxFinderThread: Thread {
    var array: [Int]
    var maxResult: Int?

    init(array: [Int]) {
        self.array = array
    }

    override func main() {
        maxResult = array.max()
    }
}

class MinFinderThread: Thread {
    var array: [Int]
    var minResult: Int?

    init(array: [Int]) {
        self.array = array
    }

    override func main() {
        minResult = array.min()
    }
}

// Завдання №2: Запис трьох масивів у файли
class SaveArrayToFileThread: Thread {
    var array: [Int]
    var fileName: String

    init(array: [Int], fileName: String) {
        self.array = array
        self.fileName = fileName
    }

    override func main() {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
        let data = array.map { String($0) }.joined(separator: "\n")
        do {
            try data.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("Failed to write to file: \(error)")
        }
    }
}

// Завдання №3: Читання вмісту файлів
class ReadFileThread: Thread {
    var fileName: String

    init(fileName: String) {
        self.fileName = fileName
    }

    override func main() {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
        do {
            let content = try String(contentsOf: fileURL)
            print("Content of file \(fileName):")
            print(content)
        } catch {
            print("Failed to read from file: \(error)")
        }
    }
}

// Завдання №4: Сортування масиву рядків у декількох потоках різними алгоритмами
class SortArrayThread: Thread {
    var array: [String]
    var sortedArray: [String]?

    init(array: [String]) {
        self.array = array
    }

    override func main() {
        // Реалізація сортування (можна вибрати будь-який алгоритм)
        sortedArray = array.sorted()
    }
}

// Головний вигляд, що містить кнопки для виклику кожного з чотирьох завдань
struct ContentView: View {
    var body: some View {
        VStack {
            Button("Виконати завдання 1") {
                // Реалізація завдання №1
                let array = [1, 5, 3, 2, 4, 6, 8, 7, 9]
                let group = DispatchGroup()
                var maxResult: Int?
                var minResult: Int?

                group.enter()
                DispatchQueue.global().async {
                    maxResult = array.max()
                    group.leave()
                }

                group.enter()
                DispatchQueue.global().async {
                    minResult = array.min()
                    group.leave()
                }

                group.notify(queue: .main) {
                    if let maxResult = maxResult {
                        print("Максимум: \(maxResult)")
                    }
                    if let minResult = minResult {
                        print("Мінімум: \(minResult)")
                    }
                }
            }
            Button("Виконати завдання 2") {
                // Реалізація завдання №2
                let array1 = [1, 2, 3, 4, 5]
                let array2 = [6, 7, 8, 9, 10]
                let array3 = [11, 12, 13, 14, 15]

                let group = DispatchGroup()

                group.enter()
                DispatchQueue.global().async {
                    let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("array1.txt")
                    let data = array1.map { String($0) }.joined(separator: "\n")
                    do {
                        try data.write(to: fileURL, atomically: true, encoding: .utf8)
                        group.leave()
                    } catch {
                        print("Failed to write to file: \(error)")
                    }
                }

                group.enter()
                DispatchQueue.global().async {
                    let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("array2.txt")
                    let data = array2.map { String($0) }.joined(separator: "\n")
                    do {
                        try data.write(to: fileURL, atomically: true, encoding: .utf8)
                        group.leave()
                    } catch {
                        print("Failed to write to file: \(error)")
                    }
                }

                group.enter()
                DispatchQueue.global().async {
                    let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("array3.txt")
                    let data = array3.map { String($0) }.joined(separator: "\n")
                    do {
                        try data.write(to: fileURL, atomically: true, encoding: .utf8)
                        group.leave()
                    } catch {
                        print("Failed to write to file: \(error)")
                    }
                }

                group.notify(queue: .main) {
                    print("Завдання 2 завершено")
                }
            }
            Button("Виконати завдання 3") {
                // Реалізація завдання №3
                let group = DispatchGroup()

                group.enter()
                DispatchQueue.global().async {
                    let readThread1 = ReadFileThread(fileName: "array1.txt")
                    readThread1.main()
                    group.leave()
                }

                group.enter()
                DispatchQueue.global().async {
                    let readThread2 = ReadFileThread(fileName: "array2.txt")
                    readThread2.main()
                    group.leave()
                }

                group.enter()
                DispatchQueue.global().async {
                    let readThread3 = ReadFileThread(fileName: "array3.txt")
                    readThread3.main()
                    group.leave()
                }

                group.notify(queue: .main) {
                    print("Завдання 3 завершено")
                }
            }
            Button("Виконати завдання 4") {
                // Реалізація завдання №4
                let array = ["banana", "apple", "grape", "orange", "pear"]
                let group = DispatchGroup()

                group.enter()
                DispatchQueue.global().async {
                    let sortThread1 = SortArrayThread(array: array)
                    sortThread1.main()
                    if let sortedArray = sortThread1.sortedArray {
                        print("Sorted array (thread 1): \(sortedArray)")
                    }
                    group.leave()
                }

                group.enter()
                DispatchQueue.global().async {
                    let sortThread2 = SortArrayThread(array: array)
                    sortThread2.main()
                    if let sortedArray = sortThread2.sortedArray {
                        print("Sorted array (thread 2): \(sortedArray)")
                    }
                    group.leave()
                }

                group.enter()
                DispatchQueue.global().async {
                    let sortThread3 = SortArrayThread(array: array)
                    sortThread3.main()
                    if let sortedArray = sortThread3.sortedArray {
                        print("Sorted array (thread 3): \(sortedArray)")
                    }
                    group.leave()
                }

                group.notify(queue: .main) {
                    print("Завдання 4 завершено")
                }
            }
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
