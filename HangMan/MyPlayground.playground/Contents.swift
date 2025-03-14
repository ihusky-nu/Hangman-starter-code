import SwiftUI
import PlaygroundSupport

// MARK: - Understanding State and Button Actions
struct CounterView: View {
    @State private var count = 0

    var body: some View {
        VStack {
            Text("Count: \(count)")
                .font(.largeTitle)
            Button("Increment") {
                count += 1
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        .padding()
    }
}

// MARK: - Understanding ForEach
struct WordListView: View {
    let words = ["Swift", "Kotlin", "Python", "JavaScript"]

    var body: some View {
        VStack {
            Text("Programming Languages")
                .font(.headline)
            
            ForEach(words, id: \.self) { word in
                Text(word)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

// MARK: - Understanding map()
let numbers = [1, 2, 3, 4]
let squaredNumbers = numbers.map { $0 * $0 }
print(squaredNumbers) // Output: [1, 4, 9, 16]


// MARK: - Understanding GridItem for Grids
struct LetterGridView: View {
    let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    let columns = Array(repeating: GridItem(.flexible()), count: 6)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(letters, id: \.self) { letter in
                Text(String(letter))
                    .frame(width: 40, height: 40)
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

// MARK: - Set up the live preview
PlaygroundPage.current.setLiveView(LetterGridView())
