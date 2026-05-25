struct TaskSection: Identifiable, Equatable {
    var id: String {
        title
    }
    var title: String
    var items: [TodoItem]
}
