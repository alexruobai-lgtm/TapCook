import AVFAudio
import Foundation

@MainActor
final class VoiceCoach {
    static let shared = VoiceCoach()
    private let synthesizer = AVSpeechSynthesizer()

    private init() {}

    func speak(_ text: String, language: CoachLanguage) {
        synthesizer.stopSpeaking(at: .immediate)
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language.rawValue)
        utterance.rate = language == .english ? 0.47 : 0.46
        utterance.pitchMultiplier = 1.02
        synthesizer.speak(utterance)
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}

enum VoicePhrase {
    static func timerPaused(_ language: CoachLanguage) -> String {
        language == .simplifiedChinese ? "计时已暂停。" : "Timer paused."
    }

    static func timerDone(_ language: CoachLanguage) -> String {
        language == .simplifiedChinese
            ? "时间到了。检查一下食物，准备好后轻点完成。"
            : "Time is up. Check the food, then tap done when you are ready."
    }

    static func completed(_ language: CoachLanguage) -> String {
        language == .simplifiedChinese
            ? "你做到了，这道菜已经完成。做得很好。"
            : "You did it. Your dish is ready. Great cooking."
    }
}
