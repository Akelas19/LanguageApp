//
//  ContentView.swift
//  LanguageApp
//
//  Created by Александр Переславцев on 12.11.2024.
//

import SwiftUI

struct MainView: View {
    //#-code-listing(AccessManagedObjectContext) [Access the managed object context]
    // Get a reference to the managed object context from the environment.
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject private var wordsViewModel = WordsViewModel()
    
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
            Spacer()
            SettingsView(viewModel: wordsViewModel)
                .navigationTitle("Главный экран")
            Spacer()
        }
    }
}

struct CardsView: View {
    @ObservedObject var viewModel: WordsViewModel
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                VStack {
                    ForEach($viewModel.sourceWords) { $word in
                        CardView(word: $word, isItSource: true) {selectedWord in viewModel.selectWord(word: selectedWord, isSource: true)}
                    }
                }
                VStack {
                    ForEach($viewModel.targetWords) { $word in
                        CardView(word: $word) {selectedWord in viewModel.selectWord(word: selectedWord, isSource: false)}
                    }
                }
            }
            //Размещение по центру экрана
            .frame(width: geometry.size.width, height: geometry.size.height * 0.7)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }.onAppear() {
            viewModel.shuffleWords()
        }
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
