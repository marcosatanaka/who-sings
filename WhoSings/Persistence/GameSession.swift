import Foundation

struct GameSession {
    var numberOfCards: Int
    var currentCard: Int
    var playerName: String?
    var points: Int

    var gameIsFinished: Bool {
        currentCard > numberOfCards
    }

    static var shared = GameSession()

    private init() {
        self.numberOfCards = 5
        self.currentCard = 1
        self.points = 0
    }
}

extension GameSession: CustomStringConvertible {
    var description: String {
        return "Total cards: \(numberOfCards) | Current card: \(currentCard) | Player: \(playerName ?? "") | Points: \(points)"
    }
}
