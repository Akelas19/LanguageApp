import Foundation
import CoreData

class WordsViewModel: ObservableObject {
    @Published var words: [Word] = []
    
    // Контекст Core Data
    private let context = PersistenceController.shared.container.viewContext
    
    // Загрузка данных из Core Data
    func fetchWords() {
        let request: NSFetchRequest<Word> = Word.fetchRequest()
        do {
            words = try context.fetch(request)
            words.forEach { $0.isMatched = false }
            saveContext()
        } catch {
            print("Failed to fetch words: \(error)")
        }
    }
    
    func addWord(source: String, target: String, tag: String) {
        let newWord = Word(context: context)
        newWord.id = UUID()
        newWord.source = source
        newWord.target = target
        newWord.isMatched = false
        newWord.tag = tag
        shuffleWords()
        saveContext()
        fetchWords()
    }
    
    func deleteWord(at offSets: IndexSet) {
        offSets.forEach { index in
            let wordToDelete = words[index]
            sourceWords = sourceWords.filter { $0.id != wordToDelete.id }
            targetWords = targetWords.filter {$0.id != wordToDelete.id }
//            targetWords.removeAll(where: {$0.id == wordToDelete.id})
            words.removeAll(where: {$0.id == wordToDelete.id})
//            print("deleteWord, \(sourceWords.map({$0.source}))")
            context.delete(wordToDelete)
        }
        
        do {
            try context.save()
        } catch {
            print("Ошибка удаления: \(error)")
        }
        shuffleWords()
        fetchWords()

    }
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }

    @Published var sourceWords: [Word] = []
    @Published var targetWords: [Word] = []
    
    @Published var selectedSource: Word?
    @Published var selectedTarget: Word?
    
    private var lastSource: Word?
    
    func selectWord(word: Word, isSource: Bool) {
//        print("VM Selected")
            
        isSource ? (selectedSource = word) : (selectedTarget = word)

        if let source = selectedSource, let target = selectedTarget {
            print("Source = \(source.source ?? "Error"), Target = \(target.target ?? "Error")")
            if source.id == target.id {
                addToInactiveWords(word: source)
//                removeMatchedWords(source: source, target: target)
            }
            selectedSource = nil
            selectedTarget = nil
        }
        
    }

    func addToInactiveWords(word: Word) {
//        print("VM ATI")
//        if let index = targetWords.firstIndex(where: {$0.id == word.id}) {
//            print("ATI T = \(targetWords[index].target!) - \(targetWords[index].isMatched)")
//            targetWords[index].toggleMatch()
//            print("ATI T = \(targetWords[index].target!) -  \(targetWords[index].isMatched)")
//        }
        
        if let index = words.firstIndex(where: {$0.id == word.id}){
            words[index].toggleMatch()
        }
        
        if !sourceWords.contains(where: {$0.isMatched == false}) {
            print("Не содержит")
            for word in sourceWords {
                print("Удаляем \(word.source ?? "Ошибка") - \(word.isMatched)")
                removeMatchedWords(source: word, target: word)
            }
        }
    }
    

    func removeMatchedWords(source: Word, target: Word) {
        print("VM RMW")
        sourceWords.removeAll(where: {$0.id == source.id})
        targetWords.removeAll(where: {$0.id == target.id})
        words.removeAll(where: {$0.id == source.id})
        if sourceWords.isEmpty {
            if words.isNotEmpty {
                print("VM RMW добавляем ++ ")
                if words.count >= 5 {
                    let selectedWords = words.shuffled().prefix(5)
                    sourceWords = selectedWords.shuffled()
                    targetWords = selectedWords.shuffled()
                } else {
                    sourceWords = words.shuffled()
                    targetWords = words.shuffled()
                }
            }
        }
    }
    
    func setWordMatched(id: UUID) {
        if let index = words.firstIndex(where: { $0.id == id }) {
            words[index].toggleMatch()            }
    }
    
    func checkForMatch() {
        
    }
    
    init() {
        fetchWords()
        shuffleWords()
    }
    
    func shuffleWords() {
        print("ShuffleWords")
        print("\(words.map({$0.source}))")
        let selectedWords = words.shuffled().prefix(5)
        print("\(selectedWords.map({$0.source}))")
        sourceWords = selectedWords.shuffled()
        targetWords = selectedWords.shuffled()
        objectWillChange.send()
    }
}

extension Array{
    var isNotEmpty : Bool {
        !self.isEmpty
    }
}
