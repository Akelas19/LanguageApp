import Foundation

//struct Words {
//    
//    private(set) var words: [Word] = []
//    
//    mutating func addWord(source: String, target: String, tag: String) {
//        words.append(Word(source: source, target: target, tag: tag))
//    }
//}

struct Word: Identifiable {
    let id: UUID
    
    private(set) var source: String
    private(set) var target: String
    private var tag: Tag
    var isMatched: Bool = false
    
    mutating func toggleMatch() {
        self.isMatched.toggle()
    }
    
    init(source: String, target: String, isMatched: Bool, tag: String) {
        self.id = UUID()
        self.source = source
        self.target = target
        self.isMatched = isMatched
        self.tag = Tag.object(data: tag)
        
    }
    
    init(source: String, target: String, tag: String) {
        self.id = UUID()
        self.source = source
        self.target = target
        self.isMatched = false
        self.tag = Tag.object(data: tag)
        
    }
    
}

enum Tag {
    case furniture
    case object(data: String)
    case animal
}
