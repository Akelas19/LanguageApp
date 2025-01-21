import Foundation

//struct Words {
//    
//    private(set) var words: [Word] = []
//    
//    mutating func addWord(source: String, target: String, tag: WordTag) {
//        words.append(Word(source: source, target: target, tag: .object))
//    }
//}

//struct Word: Identifiable, Codable {
//    let id: UUID
//    
//    private(set) var source: String
//    private(set) var target: String
//    private(set) var isMatched: Bool = false
//    private var tag: WordTag
//
//    mutating func toggleMatch() {
//        self.isMatched.toggle()
//    }
//    
//    init(source: String, target: String, isMatched: Bool, tag: WordTag) {
//        self.id = UUID()
//        self.source = source
//        self.target = target
//        self.isMatched = isMatched
//        self.tag = tag
//        
//    }
//    
//    init(source: String, target: String, tag: WordTag) {
//        self.id = UUID()
//        self.source = source
//        self.target = target
//        self.isMatched = false
//        self.tag = tag
//        
//    }
//    
//}

enum WordTag: String, Hashable, CaseIterable, Identifiable, Codable {
    var id: String {self.rawValue}
    
    case furniture = "Furniture"
    case animal = "Animal"
    case object = "Object"
    case fruit = "Fruit"
    
    
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
