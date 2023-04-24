//
//  ContentView.swift
//  Sentiment analyzer
//
//  Created by Antonio Palomba on 24/04/23.
//

import SwiftUI
// This is needed due use the NLTagger()
import NaturalLanguage

struct ContentView: View {
    @State private var inputText: String = ""

    private var score: String {
        return analyzeSentiment(for: inputText)
    }

    var body: some View {
        VStack {
            Text("Sentiment Analyzer")

            TextField("Enter Text", text: $inputText)

            Text("Score")
        }
        .padding()
    }

    private let tagger = NLTagger(tagSchemes: [.sentimentScore])

    private func analyzeSentiment(for stringToAnalyze: String) -> String {

        tagger.string = stringToAnalyze
        ///In thi case we want a tuple storing :
        /// - stringToAnalyze.startIndex refers to the starting character of the sting
        /// - unit is what we want to analyse we can choose both a word or a whole paragraph
        /// - scheme is the type of analysis that we want to run
        let (sentimentScore, _) = tagger.tag(
            at: stringToAnalyze.startIndex,
            unit: .paragraph,
            scheme: .sentimentScore
        )

        return sentimentScore?.rawValue ?? ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
