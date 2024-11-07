//
//  ProductStarsCellModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 07.11.2024.
//

import Foundation

struct ProductStarsCellModel: Equatable {
    
    let title: String?
    let rating: StarsRatingViewModel
    
    struct StarsRatingViewModel: Equatable {
        
        let currentRating: TapLocation
        
        enum TapLocation {
            case first, second, third, fourth, fifth, none
            
            static func getLocation(touch: Double, firstElementLocation: CGFloat) -> Self {
                
                switch touch {
                case 0..<firstElementLocation + 8:
                    return .first
                case firstElementLocation..<(firstElementLocation)*2:
                    return .second
                case firstElementLocation*2..<(firstElementLocation + 8)*3:
                    return .third
                case firstElementLocation*3..<(firstElementLocation + 8)*4:
                    return .fourth
                default:
                    return .fifth
                }
            }
        }
    }
}
