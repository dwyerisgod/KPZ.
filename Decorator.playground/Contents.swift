// Создать декоратор для класса "Бургер"

protocol Burger {
    func cost() -> Double
    func ingredients() -> String
}

final class CheeseBurgare: Burger {
    func cost() -> Double {
        return 20
    }
    
    func ingredients() -> String {
        return "buns, cheese, beef, lettuce, pickles, onion, condiments"
    }
}

class BurgareDecorator: Burger {
    private var burger: Burger
    
    init(burger: Burger) {
        self.burger = burger
    }
    
    func cost() -> Double {
        return burger.cost()
    }
    
    func ingredients() -> String {
        return burger.ingredients()
    }
}

final class Bacon: BurgareDecorator {
    override func cost() -> Double {
        return super.cost() + 5.9
    }
    
    override func ingredients() -> String {
        return super.ingredients() + ", bacon"
    }
}

final class Mustard: BurgareDecorator {
    override func cost() -> Double {
        return super.cost() + 11.2
    }
    
    override func ingredients() -> String {
        return super.ingredients() + ", mustard"
    }
}

final class Mayonnaise: BurgareDecorator {
    override func cost() -> Double {
        return super.cost() + 5.5
    }
    
    override func ingredients() -> String {
        return super.ingredients() + ", mayonnaise"
    }
}

let firstBurger = CheeseBurgare()
let secondsBurger = Bacon(burger: Mustard(burger: firstBurger))
let thirdBurger = Mayonnaise(burger: secondsBurger)

print("\t\t\t\t\t\t\t\t\t\t\t\tMenu:")

print("\t1st burger.")
print("Ingredients of firsts burger: \(firstBurger.ingredients())")
print("Price of the burger is \(firstBurger.cost()) kr.\n")

print("\t2nd burger.")
print("Ingredients of seconds burger: \(secondsBurger.ingredients())")
print("Price of the burger is \(secondsBurger.cost()) kr.\n")

print("\t3rd burger.")
print("Ingredients of thirds burger: \(thirdBurger.ingredients())")
print("Price of the burger is \(thirdBurger.cost()) kr.\n")
