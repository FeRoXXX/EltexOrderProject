//
//  ProductFeedbackViewModelInput.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 07.11.2024.
//

import Foundation

protocol ProductFeedbackViewModelInput {
    
    //MARK: - Function for checkbox is clicked
    func onCheckBoxTapped()
    
    //MARK: - Function for send review button is clicked
    func onSendButtonTapped()
    
    //MARK: - Function for empty media cell is clicked
    func onAddPhotoEmptyIsTapped()
    
    //MARK: - Function for new media cell is clicked
    func onAddNewPhotoIsTapped()
    
    //MARK: - Function for delete media cell is clicked
    func onDeletePhotoIsTapped(at id: UUID)
    
    //MARK: - Function for stars rating is clicked
    func onStarsRatingTapped(touch: Double, width: CGFloat)
    
    //MARK: - Function for change first responder between all textField cells
    func changeFirstResponder(id: UUID)
    
    //MARK: - The general data model
    var formattedDataList: [DataModel] { get set }
}
