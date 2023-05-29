//
//  Note.swift
//  NotesApp
//
//  Created by Азалия Халилова on 20.05.2023.
//

import Foundation

struct Note: TableViewItemProtocol {
    let title: String
    let description: String?
    let date: Date
    let imageUrl: URL?
    let image: Data? = nil
}
