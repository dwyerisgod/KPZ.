import Foundation

// RealSubject
class SecretWord {
    private let wordSets = [
        ["apple", "banana", "orange", "grape", "strawberry"],
    ]
    
    private var currentWordSetIndex = 0
    internal var secretWord: String = ""
    
    init() {
        chooseRandomWord()
    }
    
    private func chooseRandomWord() {
        let currentWordSet = wordSets[currentWordSetIndex]
        secretWord = currentWordSet.randomElement()!
    }
    
    func guessWord(_ word: String) -> Bool {
        return word.lowercased() == secretWord
    }
    
    func getMaskedWord(for guess: String) -> String {
        var maskedWord = ""
        for char in secretWord {
            if guess.contains(char) {
                maskedWord.append(char)
            } else {
                maskedWord.append("_")
            }
        }
        return maskedWord
    }
    
    func getAvailableWordSets() -> [String] {
        return wordSets.map { $0.joined(separator: ", ") }
    }
    
    func chooseWordSet(at index: Int) {
        if index >= 0 && index < wordSets.count {
            currentWordSetIndex = index
            chooseRandomWord()
        }
    }
}

// Proxy
class Proxy {
    private let realSubject = SecretWord()
    
    func guessWord(_ word: String) -> Bool {
        if word.count != realSubject.secretWord.count {
            return false
        }
        return realSubject.guessWord(word)
    }
    
    func getMaskedWord(for guess: String) -> String {
        return realSubject.getMaskedWord(for: guess)
    }
    
    func getAvailableWordSets() -> [String] {
        return realSubject.getAvailableWordSets()
    }
    
    func chooseWordSet(at index: Int) {
        realSubject.chooseWordSet(at: index)
    }
}

// Main function
func main() {
    var playAgain = true
    
    while playAgain {
        let proxy = Proxy()
        print("Welcome to Guess the Word game!")
        print("Available word sets:")
        let availableWordSets = proxy.getAvailableWordSets()
        for (index, wordSet) in availableWordSets.enumerated() {
            print("\(index + 1). \(wordSet)")
        }
        
        var guessed = false
        while !guessed {
            let maskedWord = proxy.getMaskedWord(for: "")
            print("Guess the word: \(maskedWord)")
            print("Enter your guess: ", terminator: "")
            if let guess = readLine() {
                if proxy.guessWord(guess) {
                    print("Congratulations! You guessed the word!")
                    guessed = true
                } else {
                    print("Sorry, try again.")
                }
            }
        }
        
        print("Do you want to play again? (yes/no): ", terminator: "")
        if let input = readLine()?.lowercased(), input != "yes" {
            playAgain = false
        }
    }
}

// Run the game
main()
