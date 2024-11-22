import Foundation

class WordsViewModel: ObservableObject {
    // Публикуемое свойство, которое UI будет наблюдать
    @Published var words: [Word] = [
        Word(source: "Арбуз", target: "Melon", tag: "Fruit"),
        Word(source: "Банан", target: "Banana", tag: "Fruit"),
        Word(source: "Виноград", target: "Grape", tag: "Fruit"),
        Word(source: "Стол", target: "Table", tag: "Furniture"),
        Word(source: "Стул", target: "Chair", tag: "Furniture"),
        Word(source: "Микроволновка", target: "Microwave", tag: "Furniture"),
//        Word(source: "Диван", target: "Sofa", tag: "Furniture"),
//        Word(source: "Окно", target: "Window", tag: "Furniture"),
//        Word(source: "Телевизор", target: "Tv", tag: "Furniture"),
//        Word(source: "Холодильник", target: "Refrigerator", tag: "Furniture"),
//        Word(source: "Лампа", target: "Lamp", tag: "Furniture"),
//        Word(source: "Книга", target: "Book", tag: "Object"),
//        Word(source: "Ручка", target: "Pen", tag: "Object"),
//        Word(source: "Дверь", target: "Door", tag: "Furniture")
    ]
    
    @Published var sourceWords: [Word] = []
    @Published var targetWords: [Word] = []
    
    func toggleWord() {
        words[0].toggleMatch()
    }
    
    init() {
        let selectedWords = words.prefix(5)
        
        // Заполняем sourceWords и targetWords
        sourceWords = selectedWords.map { $0 }.shuffled()
        targetWords = selectedWords.map { $0 }.shuffled()
    }
    func setWordMatched(id: UUID) {
            if let index = words.firstIndex(where: { $0.id == id }) {
                words[index].toggleMatch()            }
        }
    
      
    func addWord(word: Word) {
            words.append(word)
        }
    
//    func addWord(source: String, target: String, tag: String) {
//        wordsModel.addWord(source: source, target: target, tag: tag)
//        
//        // MARK: – Bug Это нужно чтобы words обновлялось, потому что оно автоматически не обновляется когда обновляется модель, в которой words содержатся
//        words = wordsModel.words
//    }
    
}
