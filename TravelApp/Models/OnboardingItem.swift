//
//  OnboardingItem.swift
//  TravelApp
//
//  Created by Anderson Oliveira on 01/04/23.
//

import UIKit

struct OnboardingItem {
    let title: String
    let detail: String
    let bgImage: UIImage?
    
    
    static func getOnboardingItems() -> [OnboardingItem] {
        [
            .init(title: "Trabel Your Way",
                  detail: "Travel the world by air, rail or sea at the most competitive prices",
                  bgImage: UIImage(named: "firstTravel")),
            .init(title: "Stay Your Way",
                  detail: "With over millions of hotels worldwide, find the perfect accomodation in the most amazing places",
                  bgImage: UIImage(named: "secondTravel")),
            .init(title: "Discover Your Way With New Features",
                  detail: "Explore exotic destinations with out new features that link you to linke-minded trabellers!",
                  bgImage: UIImage(named: "thirdTravel")),
            .init(title: "Feast Your Way",
                  detail: "We recommend you local coisines that are safe and highly recommended by the locals!",
                  bgImage: UIImage(named: "fourthTravel"))
        ]
    }
}
