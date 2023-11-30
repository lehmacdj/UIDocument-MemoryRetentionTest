//
//  ContentView.swift
//  MemoryRetentionTest
//
//  Created by Devin Lehmacher on 10/31/23.
//

import SwiftUI

struct CoverView: View {
    var body: some View {
        Text("View that covers up other view")
    }
}

struct ContentView: View {
    @State var file: Result<URL, Error>?
    @State var showingDocumentPicker = false
    var body: some View {
        NavigationStack {
            VStack {
                if let file, case .success(let url) = file{
                    Text("View with .task")
                        .task {
                            let doc = DocumentWrapper(wrapped: Document(fileURL: url))
                            await doc.wrapped.open()
                            print("opened doc")
                            do {
                                while true {
                                    try await Task.sleep(for: .seconds(1))
                                }
                            } catch is CancellationError {
                                print("cancelled!")
                            } catch {
                                print("unexpected error")
                            }
                        }
                } else if let file, case .failure(let error) = file {
                    Text("\(error.localizedDescription)").foregroundStyle(Color.red)
                } else {
                    Button("Pick a document") {
                        showingDocumentPicker = true
                    }
                    .fileImporter(isPresented: $showingDocumentPicker, allowedContentTypes: [.text]) {
                        file = $0
                    }
                }
                NavigationLink(destination: CoverView()) {
                    Text("Cover Up")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
