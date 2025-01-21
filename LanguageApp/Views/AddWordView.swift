//
//  AddWordView.swift
//  LanguageApp
//
//  Created by Александр Переславцев on 07.12.2024.
//

import SwiftUI

struct AddWordView: View {
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
                viewModel.addWord(source: source, target: target, tag: selectedTag.rawValue)
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

