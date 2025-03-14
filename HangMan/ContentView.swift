import SwiftUI
struct HangmanGameView: View {
    @State private var wordToGuess = "SWIFT"
    @State private var guessedLetters: [Character] = []
    @State private var incorrectGuesses = 0
    @State private var gameOver = false
    
    let maxAttempts = 6
    
    var displayedWord: String {
        wordToGuess.map { guessedLetters.contains($0) ? String($0) : "_" }.joined(separator: " ")
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Hangman")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            HangmanDrawing(incorrectGuesses: incorrectGuesses)
                .frame(height: 200)
            
            Text(displayedWord)
                .font(.title)
                .padding()
            
            Text("Incorrect guesses: \(incorrectGuesses)/\(maxAttempts)")
                .foregroundColor(.red)
                .font(.headline)
                .padding()
            
            if gameOver {
                Text("Game Over! The word was \(wordToGuess)")
                    .foregroundColor(.red)
                    .font(.title2)
            } else {
                LetterInputView(guessedLetters: $guessedLetters, incorrectGuesses: $incorrectGuesses, wordToGuess: wordToGuess, gameOver: $gameOver)
            }
        }
        .padding()
    }
}
struct HangmanDrawing: View {
    let incorrectGuesses: Int
    
    var body: some View {
        ZStack {
            if incorrectGuesses > 0 { Circle().stroke().frame(width: 40, height: 40).offset(y: -80) } // Head
            if incorrectGuesses > 1 { Rectangle().frame(width: 5, height: 50).offset(y: -40) } // Body
            if incorrectGuesses > 2 { Rectangle().frame(width: 40, height: 5).rotationEffect(.degrees(-30)).offset(x: -20, y: -50) } // Left Arm
            if incorrectGuesses > 3 { Rectangle().frame(width: 40, height: 5).rotationEffect(.degrees(30)).offset(x: 20, y: -50) } // Right Arm
            if incorrectGuesses > 4 { Rectangle().frame(width: 5, height: 50).rotationEffect(.degrees(15)).offset(x: -10, y: 10) } // Left Leg
            if incorrectGuesses > 5 { Rectangle().frame(width: 5, height: 50).rotationEffect(.degrees(-15)).offset(x: 10, y: 10) } // Right Leg
        }
    }
}
struct LetterInputView: View {
    @Binding var guessedLetters: [Character]
    @Binding var incorrectGuesses: Int
    let wordToGuess: String
    @Binding var gameOver: Bool
    
    let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6)) {
            ForEach(alphabet.map { String($0) }, id: \.self) { letter in
                Button(letter) {
                    makeGuess(letter: Character(letter))
                }
                .disabled(guessedLetters.contains(Character(letter)) || gameOver)
                .padding()
                .background(Color.blue.opacity(0.7))
                .foregroundColor(.white)
                .clipShape(Circle())
            }
        }
    }
    
    func makeGuess(letter: Character) {
        if wordToGuess.contains(letter) {
            guessedLetters.append(letter)
        } else {
            incorrectGuesses += 1
        }
        
        if incorrectGuesses >= 6 || !wordToGuess.map({ guessedLetters.contains($0) }).contains(false) {
            gameOver = true
        }
    }
}
struct ContentView: View {
    var body: some View {
        HangmanGameView()
    }
}
@main
struct HangmanApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}



