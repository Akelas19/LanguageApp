import SwiftUI

struct SettingsWords: View {
    @ObservedObject var viewModel: WordsViewModel
    @State private var showAlert = false // Переменная для отображения Alert
    @State private var indexToDelete: IndexSet? = nil // Сохраняем индекс для удаления
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.words) { word in
                    HStack {
                        Text(word.source ?? "SOURCE")
                        Spacer()
                        Text(word.target ?? "TARGET")
                    }
                }
                .onDelete { offsets in
                    self.indexToDelete = offsets
                    self.showAlert = true // Показываем Alert перед удалением
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Удалить слово?"),
                message: Text("Вы уверены, что хотите удалить это слово?"),
                primaryButton: .destructive(Text("Удалить")) {
                    if let offsets = indexToDelete {
                        viewModel.deleteWord(at: offsets) // Выполняем удаление, если подтверждено
                    }
                },
                secondaryButton: .cancel() // Отменить удаление
            )
        }
    }
    
    func delete(at offsets: IndexSet) {
        viewModel.deleteWord(at: offsets)
    }
}
