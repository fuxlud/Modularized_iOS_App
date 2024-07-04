public struct BreedsDTO: Decodable {

    let breeds: [BreedDTO]
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BreedKey.self)
        var extractedBreeds: [BreedDTO] = []
        for key in container.allKeys{
            extractedBreeds.append(BreedDTO(name: key.stringValue))
        }
        breeds = extractedBreeds
    }

    struct BreedKey: CodingKey {
        
        var stringValue: String
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int? { return nil }
        init?(intValue: Int) { return nil }
    }
}
