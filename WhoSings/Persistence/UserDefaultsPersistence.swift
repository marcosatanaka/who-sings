import Foundation

class UserDefaultsPersistence {

    private static var usersScores: [String: [Int]] {
        get {
            return UserDefaults.standard.object(forKey: "usersScores") as? [String: [Int]] ?? [:]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "usersScores")
        }
    }

    static func addScore(of score: Int, to username: String) {
        var userScores = UserDefaultsPersistence.usersScores[username] ?? []
        userScores.append(score)
        UserDefaultsPersistence.usersScores[username] = userScores
    }

    static func getHighscoreList() -> [PlayerScoreModel] {
        var highscores = [PlayerScoreModel]()
        for userScores in usersScores {
            for score in userScores.value {
                highscores.append(PlayerScoreModel(playerName: userScores.key, score: score))
            }
        }
        return highscores.sorted(by: { $0.score > $1.score })
    }

}

// MARK: - PlayerScoreModel

struct PlayerScoreModel {
    let playerName: String
    let score: Int
}
