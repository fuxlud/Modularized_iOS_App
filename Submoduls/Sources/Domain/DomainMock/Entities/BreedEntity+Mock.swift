import Foundation

public extension BreedEntity {
    
    static let mock = [
        BreedEntity(name: "Golden Retriever",
                    breedImages: [
                        BreedDetailsEntity(url: URL(string: "https://example.com/images/golden1.jpg")!, isFavorite: true),
                        BreedDetailsEntity(url: URL(string: "https://example.com/images/golden2.jpg")!, isFavorite: false)
                    ]),
        
        BreedEntity(name: "Labrador Retriever",
                    breedImages: [
                        BreedDetailsEntity(url: URL(string: "https://example.com/images/labrador1.jpg")!, isFavorite: true),
                        BreedDetailsEntity(url: URL(string: "https://example.com/images/labrador2.jpg")!, isFavorite: false)
                    ]),
        
        BreedEntity(name: "German Shepherd",
                    breedImages: [
                        BreedDetailsEntity(url: URL(string: "https://example.com/images/germanshepherd1.jpg")!, isFavorite: true),
                        BreedDetailsEntity(url: URL(string: "https://example.com/images/germanshepherd2.jpg")!, isFavorite: false)
                    ]),
        
        BreedEntity(name: "Bulldog",
                    breedImages: [
                        BreedDetailsEntity(url: URL(string: "https://example.com/images/bulldog1.jpg")!, isFavorite: true),
                        BreedDetailsEntity(url: URL(string: "https://example.com/images/bulldog2.jpg")!, isFavorite: false)
                    ]),
        
        BreedEntity(name: "Beagle",
                    breedImages: [
                        BreedDetailsEntity(url: URL(string: "https://example.com/images/beagle1.jpg")!, isFavorite: true),
                        BreedDetailsEntity(url: URL(string: "https://example.com/images/beagle2.jpg")!, isFavorite: false)
                    ]),
        
        BreedEntity(name: "Poodle",
                    breedImages: [
                        BreedDetailsEntity(url: URL(string: "https://example.com/images/poodle1.jpg")!, isFavorite: true),
                        BreedDetailsEntity(url: URL(string: "https://example.com/images/poodle2.jpg")!, isFavorite: false)
                    ]),
        
        BreedEntity(name: "Rottweiler",
                    breedImages: [
                        BreedDetailsEntity(url: URL(string: "https://example.com/images/rottweiler1.jpg")!, isFavorite: true),
                        BreedDetailsEntity(url: URL(string: "https://example.com/images/rottweiler2.jpg")!, isFavorite: false)
                    ]),
        
        BreedEntity(name: "Yorkshire Terrier",
                    breedImages: [
                        BreedDetailsEntity(url: URL(string: "https://example.com/images/yorkshireterrier1.jpg")!, isFavorite: true),
                        BreedDetailsEntity(url: URL(string: "https://example.com/images/yorkshireterrier2.jpg")!, isFavorite: false)
                    ]),
        
        BreedEntity(name: "Boxer",
                    breedImages: [
                        BreedDetailsEntity(url: URL(string: "https://example.com/images/boxer1.jpg")!, isFavorite: true),
                        BreedDetailsEntity(url: URL(string: "https://example.com/images/boxer2.jpg")!, isFavorite: false)
                    ]),
        
        BreedEntity(name: "Dachshund",
                    breedImages: [
                        BreedDetailsEntity(url: URL(string: "https://example.com/images/dachshund1.jpg")!, isFavorite: true),
                        BreedDetailsEntity(url: URL(string: "https://example.com/images/dachshund2.jpg")!, isFavorite: false)
                    ])
    ]
}
