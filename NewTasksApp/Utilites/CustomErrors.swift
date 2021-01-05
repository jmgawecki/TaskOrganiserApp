//
//  CustomErrors.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 25/12/2020.
//

import UIKit

enum CustomErrors: String, Error {
    case unableToNotes  = "Unable to send the note. Please try again"
    case inNotes        = "That note is already in your notes ;)"
}
