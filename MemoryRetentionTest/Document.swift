//
//  Document.swift
//  MemoryRetentionTest
//
//  Created by Devin Lehmacher on 11/30/23.
//

import UIKit

class DocumentWrapper {
    let wrapped: Document
    init(wrapped: Document) {
        self.wrapped = wrapped
    }
    deinit {
        Task { [wrapped] in
//            await wrapped.close()
        }
    }
}

class Document: UIDocument {
    override func contents(forType typeName: String) throws -> Any {
        Data()
    }

    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        print("loaded from contents")
    }
}
