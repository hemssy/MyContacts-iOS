import Foundation
import UIKit

struct PokemonResponse: Decodable {
    let sprites: Sprites
    struct Sprites: Decodable {
        let front_default: String?
    }
}

enum PokemonAPI {

    static func fetchRandomPokemonImage(completion: @escaping (UIImage?) -> Void) {
        let id = Int.random(in: 1...1000)
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)") else {
            DispatchQueue.main.async { completion(nil) }
            return
        }


        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard
                let data = data,
                let pokemon = try? JSONDecoder().decode(PokemonResponse.self, from: data),
                let imgURLString = pokemon.sprites.front_default,
                let imgURL = URL(string: imgURLString)
            else {
                DispatchQueue.main.async { completion(nil) }
                return
            }


            URLSession.shared.dataTask(with: imgURL) { imgData, _, _ in
                var image: UIImage? = nil
                if let data = imgData {
                    image = UIImage(data: data)
                }
                DispatchQueue.main.async { completion(image) }
            }.resume()

        }.resume()
    }
}

