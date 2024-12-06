import Foundation

class WordsViewModel: ObservableObject {
    // Публикуемое свойство, которое UI будет наблюдать
    @Published var words: [Word] = [
        Word(source: "Арбуз", target: "Melon", tag: WordTag.fruit),
        Word(source: "Банан", target: "Banana", tag: WordTag.fruit),
        Word(source: "Виноград", target: "Grape", tag: WordTag.fruit),
        Word(source: "Стол", target: "Table", tag: WordTag.furniture),
        Word(source: "Микроволновка", target: "Microwave", tag: WordTag.furniture),
        Word(source: "Стул", target: "Chair", tag: WordTag.furniture),
        Word(source: "Диван", target: "Sofa", tag: WordTag.furniture),
        Word(source: "Окно", target: "Window", tag: WordTag.furniture),
        Word(source: "Телевизор", target: "Tv", tag: WordTag.furniture),
//        Word(source: "Холодильник", target: "Refrigerator", tag: WordTag.furniture),
//        Word(source: "Лампа", target: "Lamp", tag: WordTag.furniture),
//        Word(source: "Книга", target: "Book", tag: WordTag.object),
//        Word(source: "Ручка", target: "Pen", tag: WordTag.object),
//        Word(source: "Дверь", target: "Door", tag: WordTag.furniture)
    ]
    
    @Published var sourceWords: [Word] = []
    @Published var targetWords: [Word] = []
    
    private var selectedSource: Word?
    private var selectedTarget: Word?
    
    private var lastSource: Word?
    
    func selecetWord(word: Word, isSource: Bool) {
        if isSource {
            selectedSource = word
        } else {
            selectedTarget = word
        }
        
        if let source = selectedSource, let target = selectedTarget {
            if source.id == target.id {
                removeMatchedWords(source: source, target: target)
            }
        }
        
    }
    
    func removeMatchedWords(source: Word, target: Word) {
        sourceWords.removeAll(where: {$0.id == source.id})
        targetWords.removeAll(where: {$0.id == source.id})
        words.removeAll(where: {$0.id == source.id})
        if sourceWords.isEmpty {
            if words.isNotEmpty {
                if words.count >= 5 {
                    let selectedWords = words.prefix(5)
                    sourceWords = selectedWords.shuffled()
                    targetWords = selectedWords.shuffled()
                } else {
                    sourceWords = words.shuffled()
                    targetWords = words.shuffled()
                }
                
            }
        }
        
    }
    
    func toggleWord() {
        words[0].toggleMatch()
    }
    
    init() {
        let selectedWords = words.prefix(5)
        sourceWords = selectedWords.shuffled()
        targetWords = selectedWords.shuffled()
    }
    func setWordMatched(id: UUID) {
        if let index = words.firstIndex(where: { $0.id == id }) {
            words[index].toggleMatch()            }
    }
    
    func checkForMatch() {
        
    }
    
    func addWord(word: Word) {
        words.append(word)
    }
    
    func removeWord(word: Word) {
        guard words.contains(where: { $0.id == word.id }) else {
            print("Элемент с id \(word.id) не найден.")
            return
        }
        words.removeAll(where: { $0.id == word.id })
    }
    
    func removeWordIndex(index: IndexSet) {
        var word: Word
        if let index = index.first {
            var word = words[index]
        }
        word
    }
    
    //    func addWord(source: String, target: String, tag: String) {
    //        wordsModel.addWord(source: source, target: target, tag: tag)
    //
    //        // MARK: – Bug Это нужно чтобы words обновлялось, потому что оно автоматически не обновляется когда обновляется модель, в которой words содержатся
    //        words = wordsModel.words
    //    }
    
}

extension Array{
    var isNotEmpty : Bool {
        !self.isEmpty
    }
}
