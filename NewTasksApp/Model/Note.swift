//
//  Note.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 25/12/2020.
//

import UIKit

struct Note: Hashable, Codable {
    var title:  String
    var note:   String?
    let noteId: String
}
