//
//  SettingsView.swift
//  LanguageApp
//
//  Created by Александр Переславцев on 07.12.2024.
//

import SwiftUI

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
            AddWordView(viewModel: viewModel)
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
        Button{addSampleWords()} label: {
            Text("Добавить много слов")
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
        .sheet(isPresented: $isSettingsWordsPresented, onDismiss: {}) { SettingsWords(viewModel: viewModel)
        }
        
    }
    
    func addSampleWords() {
            let sampleWords = [
                ("Арбуз", "Melon", "fruit"),
                ("Банан", "Banana", "fruit"),
                ("Виноград", "Grape", "fruit"),
                ("Стол", "Table", "furniture"),
                ("Микроволновка", "Microwave", "furniture"),
                ("Стул", "Chair", "furniture"),
                ("Диван", "Sofa", "furniture"),
                ("Окно", "Window", "furniture"),
                ("Телевизор", "Tv", "furniture"),
                ("Холодильник", "Refrigerator", "furniture"),
                ("Лампа", "Lamp", "furniture"),
                ("Книга", "Book", "object"),
                ("Ручка", "Pen", "object"),
                ("Дверь", "Door", "furniture")
            ]

            for word in sampleWords {
                viewModel.addWord(source: word.0, target: word.1, tag: word.2)
            }
        }
}
