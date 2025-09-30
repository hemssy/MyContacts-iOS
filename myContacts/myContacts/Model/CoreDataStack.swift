import CoreData

enum CoreDataStack {

    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PhoneBookModel")
        container.loadPersistentStores { _, error in
            if let error = error { fatalError("코어데이터 로드 에러: \(error)") }
        }

        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()

    static var context: NSManagedObjectContext { container.viewContext }

    @discardableResult
    static func saveContextIfNeeded() -> Bool {
        let ctx = container.viewContext
        guard ctx.hasChanges else { return true }
        do {
            try ctx.save()
            return true
        } catch {
            print("코어데이터 세이브 에러:", error)
            return false
        }
    }
}

