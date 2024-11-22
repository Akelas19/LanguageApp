//
//  ContentView.swift
//  LanguageApp
//
//  Created by Александр Переславцев on 12.11.2024.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var viewModel = WordsViewModel()
    
    var word = Word(source: "Ноутбук", target: "Laptop", tag: "Device")
    var body: some View {
        NavigationStack{
            HStack(
                alignment: .bottom,
                spacing: 30
            ) {
                NavigationLink(
                    destination: CardsView(viewModel: viewModel),
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
                    destination: SettingsView(),
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

//            .frame(width: 500, height: 40)
//            .background(Color(red:0.1, green: 0.1, blue: 0.1))
            Spacer()
            Text("CardView(word: word)")

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
                    ForEach(viewModel.sourceWords) { word in
                        CardView(word: $viewModel.words[viewModel.words.firstIndex(where: { $0.id == word.id })!], text: word.source, viewmodel: viewModel)
                    }}
                    VStack {
                        ForEach(viewModel.targetWords) { word in
                            CardView(word: $viewModel.words[viewModel.words.firstIndex(where: { $0.id == word.id })!], text: word.target, viewmodel: viewModel)
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height * 0.7)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2) // Разместим по центру экрана
            }
        }
    
}

struct CardView: View {
    @Binding var word: Word // Используем @Binding для того, чтобы изменять данные
    var text: String = "Word"
    @ObservedObject var viewmodel: WordsViewModel
    
    var body: some View {
        GeometryReader { geometry in
            Button {
                print("Card \(text)")
                print(viewmodel.sourceWords[0].isMatched)
                viewmodel.toggleWord()
                print(viewmodel.sourceWords[0].isMatched)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.black, lineWidth: 5)
                    Text(word.isMatched ? "Matched" : text) // Показываем статус
                        .font(.title2)
                        .foregroundStyle(.black)
                        .padding(10)
                }
                .padding(5)
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height) // Заданный размер кнопки
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
    }
}

struct SettingsView: View {
    var body: some View {
        Button{} label: {
        Text("Добавить слова")
            .foregroundStyle(.white)
            .font(.largeTitle)
        .padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(.blue)
            )
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
        Button{} label: {
            Text("Настроить слова")
                .foregroundStyle(.white)
                .font(.largeTitle)
            .padding()
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.blue)
                )
        }
    }
}

//        Circle()
//            .fill(Color.blue)
//            .frame(width: 200, height: 200)
//            .mask(
//                Rectangle()
//                    .frame(width: 200, height: 100)
//                    .offset(y: -50) // Сдвиг маски для верхней половины
//            )


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
//    MainView()
    CardsView(viewModel: WordsViewModel())
}


