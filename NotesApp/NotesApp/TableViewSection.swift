//
//  TableViewSection.swift
//  NotesApp
//
//  Created by Азалия Халилова on 20.05.2023.
//

import Foundation

protocol TableViewItemProtocol { }

struct TableViewSection {
    var title: String?
    var items: [TableViewItemProtocol]
}
