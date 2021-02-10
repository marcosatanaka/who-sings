import Foundation
import os.log

extension Logger {
    static let network = Logger(subsystem: "br.com.marcosatanaka.whosings", category: "🌐")
    static let quiz = Logger(subsystem: "br.com.marcosatanaka.whosings", category: "🧐")
    static let gameSession = Logger(subsystem: "br.com.marcosatanaka.whosings", category: "🕹")
    static let memory = Logger(subsystem: "br.com.marcosatanaka.whosings", category: "🔗")
}
