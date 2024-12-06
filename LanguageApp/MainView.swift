//
//  ContentView.swift
//  LanguageApp
//
//  Created by Александр Переславцев on 12.11.2024.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var wordsViewModel = WordsViewModel()
    var word = Word(source: "Ноутбук", target: "Laptop", tag: WordTag.furniture)
    var body: some View {
        NavigationStack{
            HStack(
                alignment: .bottom,
                spacing: 30
            ) {
                NavigationLink(
                    destination: CardsView(viewModel: wordsViewModel),
                    label: {
                        Text("1")
                            .foregroundStyle(.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(.blue)
                            )
                    }
                )
                NavigationLink(
                    destination: Text("CardView(word: word)"),
                    label: {
                        Text("2")
                            .foregroundStyle(.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(.blue)
                            )
                    }
                )
                NavigationLink(
                    destination: Text("CardView(word: word)"),
                    label: {
                        Text("3")
                            .foregroundStyle(.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(.blue)
                            )
                    }
                )
                NavigationLink(
                    destination: SettingsView(viewModel: wordsViewModel),
                    label: {
                        Text("Настройки")
                            .foregroundStyle(.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(.blue)
                            )
                    }
                )
            }
            .navigationTitle("Главный экран")
            Spacer()
        }
    }
}

struct CardsView: View {
    @ObservedObject var viewModel: WordsViewModel
    
    //    var body: some View{
    //        HStack{
    //
    //            Button{
    //
    //            } label: {
    //                ZStack{
    //                    RoundedRectangle(cornerRadius: 20)
    //                        .frame(width: 150, height: 150)
    //                        .foregroundStyle(.mint)
    //                    Text("Xexe")
    //                        .font(.title)
    //                }
    //            }
    //            Button{
    //
    //            } label: {
    //                ZStack{
    //                    RoundedRectangle(cornerRadius: 20)
    //                        .frame(width: 150, height: 150)
    //                        .foregroundStyle(.mint)
    //                    Text("Xexe")
    //                        .font(.title)
    //                }
    //            }
    //
    //        }
    //    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                VStack {
                    ForEach($viewModel.sourceWords) { $word in
                        CardView(word: $word, isItSource: true) {selectedWord in viewModel.selecetWord(word: selectedWord, isSource: true)}
                    }}
                VStack {
                    ForEach($viewModel.targetWords) { $word in
                        CardView(word: $word) {selectedWord in viewModel.selecetWord(word: selectedWord, isSource: false)}
                    }
                }
            }
            //Размещение по центру экрана
            .frame(width: geometry.size.width, height: geometry.size.height * 0.7)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
    }
    
}

struct CardView: View {
    @Binding var word: Word
    var isItSource: Bool = false
    @State var isSelected: Bool = false
    var onCardSelected: (Word) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            Button {
                print("\nCard \(word.source)")
                print(word.isMatched)
                word.toggleMatch()
                print(word.isMatched)
                isSelected.toggle()
                onCardSelected(word)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(isSelected ? .cyan : .clear)
                        .stroke(Color.black, lineWidth: 5)
                    Text(isItSource ? word.source : word.target)
                        .font(.title2)
                        .foregroundStyle(.black)
                        .padding(10)
                }
                .padding(5)
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 1) // Заданный размер кнопки
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
    }
}

struct SettingsView: View {
    @ObservedObject var viewModel : WordsViewModel
    @State private var isAddSheetPresented = false
    @State private var isSettingsWordsPresented = false

    
    var body: some View {
        Button{
            isAddSheetPresented.toggle()
        } label: {
            Text("Добавить слово")
                .foregroundStyle(.white)
                .font(.largeTitle)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.blue)
                )
        }
        .sheet(isPresented: $isAddSheetPresented) {
            AddWordsView(viewModel: viewModel)
                }
        
        Button{} label: {
            Text("Поменять тему")
                .foregroundStyle(.white)
                .font(.largeTitle)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.blue)
                )
        }
        Button{
            isSettingsWordsPresented.toggle()
        } label: {
            Text("Настроить слова")
                .foregroundStyle(.white)
                .font(.largeTitle)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.blue)
                )
        }
        .sheet(isPresented: $isSettingsWordsPresented) { SettingsWords(viewModel: viewModel)
        }
    }
}

struct AddWordsView: View {
    @ObservedObject var viewModel : WordsViewModel

    @State private var source = ""
    @State private var target = ""
    
    @State private var selectedTag: WordTag = .furniture

    var body: some View {
        VStack(spacing: 20) {
            Text("Добавить слово")
                .font(.title)
                .padding()

            TextField("Введите исходное слово", text: $source)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Введите перевод слова", text: $target)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Picker("Select a Tag", selection: $selectedTag) {
                ForEach(WordTag.allCases) { tag in
                    Text(tag.displayName).tag(tag)
                }
            }
            .padding()
            
            Button{
                let newWord = Word(source: source, target: target, tag: WordTag.object)
                viewModel.addWord(word: newWord)
                clearFields()
            } label: {
                Text("Добавить слово")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            //Блокировка кнопки если поля пустые
            .disabled(source.isEmpty || target.isEmpty)
            .padding()
        }
        .padding()
    }

    private func clearFields() {
        source = ""
        target = ""
    }
}

struct SettingsWords: View {
    @ObservedObject var viewModel : WordsViewModel
    
    var body: some View {
        Text("SettingsWords")
        List {
            ForEach(viewModel.words) { fruit in
                HStack{
                    Text(fruit.source)
                    Spacer()
                    Text(fruit.target)
                }
            }
            .onDelete(perform: delete)
        }
    }
    
    func delete(at offsets: IndexSet) {
        viewModel.words.remove(atOffsets: offsets)
    }
}

struct ButtonFormat: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundStyle(.secondary)
    }
}

extension View {
    func buttonFormat() -> some View {
        modifier(ButtonFormat())
    }
}




#Preview {
    MainView()
//        CardsView(viewModel: WordsViewModel())
}

//        Circle()
//            .fill(Color.blue)
//            .frame(width: 200, height: 200)
//            .mask(
//                Rectangle()
//                    .frame(width: 200, height: 100)
//                    .offset(y: -50) // Сдвиг маски для верхней половины
//            )
