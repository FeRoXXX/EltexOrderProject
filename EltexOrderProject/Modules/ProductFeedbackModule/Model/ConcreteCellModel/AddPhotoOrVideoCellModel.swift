//
//  AddPhotoOrVideoCellModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 07.11.2024.
//

import Foundation

struct AddPhotoOrVideoCellModel: Equatable {
    var cell: [PhotoCellModel]
    
    struct PhotoCellModel: Equatable {
        let image: String?
        let id: UUID = UUID()
    }
}
