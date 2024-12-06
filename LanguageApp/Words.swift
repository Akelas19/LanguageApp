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
    private var tag: WordTag
    private(set) var isMatched: Bool = false
    
    mutating func toggleMatch() {
        self.isMatched.toggle()
    }
    
    init(source: String, target: String, isMatched: Bool, tag: WordTag) {
        self.id = UUID()
        self.source = source
        self.target = target
        self.isMatched = isMatched
        self.tag = tag
        
    }
    
    init(source: String, target: String, tag: WordTag) {
        self.id = UUID()
        self.source = source
        self.target = target
        self.isMatched = false
        self.tag = tag
        
    }
    
}

enum WordTag: String, Hashable, CaseIterable, Identifiable {
    var id: String {self.rawValue}
    
//    case furniture(data: String)
    case furniture = "Furniture"
    case animal = "Animal"
    case object = "Object"
    case fruit = "Fruit"
    
//    case object(data: String)
//    case animal(data: String)
    
    var displayName: String {
            switch self {
            case .furniture: return "Furniture"
            case .object: return "Object"
            case .animal: return "Animal"
            case .fruit: return "Fruit"
            }
        }
    
    func hash(into hasher: inout Hasher) {
            switch self {
            case .furniture:
                hasher.combine("furniture")
            case .animal:
                hasher.combine("animal")
            case .object:
                hasher.combine("object")
            case .fruit:
                hasher.combine("fruit")
            }
        }
}
