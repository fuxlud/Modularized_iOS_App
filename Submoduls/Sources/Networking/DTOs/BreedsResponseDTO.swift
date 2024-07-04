struct BreedsResponseDTO: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case breeds = "message"
    }
    
    let breeds: BreedsDTO
}
