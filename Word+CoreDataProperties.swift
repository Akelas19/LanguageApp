import Foundation
import CoreData


extension Word {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: "Word")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isMatched: Bool
    @NSManaged public var source: String?
    @NSManaged public var tag: String?
    @NSManaged public var target: String?

}

extension Word : Identifiable {
    var wordTag: WordTag {
        get {
            WordTag(rawValue: tag ?? "") ?? .object
        }
        set {
            tag = newValue.rawValue
        }
    }
    
    func toggleMatch() {
        isMatched.toggle()
    }
}
