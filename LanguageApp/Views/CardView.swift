import SwiftUI

struct CardView: View {
    @Binding var word: Word
    var isItSource: Bool = false
    @State var isSelected: Bool = false
    var onCardSelected: (Word) -> Void
    @State private var isColorChanged = false // Флаг для отслеживания изменения цвета
    
    var body: some View {
        GeometryReader { geometry in
            Button {
                isColorChanged = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    isColorChanged = false
                }
                isSelected.toggle()
                print("OnCardSelected")
                onCardSelected(word)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(isColorChanged ? (word.isMatched ? .clear : .cyan) : .clear)
                        .stroke(Color.black, lineWidth: 5)
                    // MARK: - bug
                    Text(isItSource ? word.source ?? "SOURCE" : word.target ?? "TARGET")
                        .font(.title2)
                        .foregroundStyle(.black)
                        .padding(10)
                }
                .padding(5)
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 1)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                .opacity(word.isMatched ? 0.2 : 1.0)  // Прозрачность
                
            }
            .disabled(word.isMatched)
        }
    }
}
