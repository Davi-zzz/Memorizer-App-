import Foundation

// Aqui está a nossa ViewModel
class EmojiMemoryGame: ObservableObject {
    
    // Nossa ViewModel possui uma var que é o Model, ele pode conversar com o Model de uma vez
    @Published private var model: MemoryGame<String> = {
        let emojis = ["🧛🏻‍♂️", "🕷️", "🤡"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }()
    
    // MARK: - Access to the model
    
    // Como pegar os cartões e também deixar
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // Acesso ao público ao modelo, que de outra forma seria privado!
    
    // MARK: - Intent(s)
    
    // A visualização expressa sua Intenção, nesse caso, escolher um cartão
    func selectCard(_ card: MemoryGame<String>.Card, onMatch: @escaping () -> Void) {
        objectWillChange.send()
        model.choose(card: card, onMatch: onMatch)
    }
}
