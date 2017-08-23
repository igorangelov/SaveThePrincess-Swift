import Foundation

extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<10
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}

//var organisms = [
//    "ant",  "bacteria", "cougar",
//    "dog",  "elephant", "firefly",
//    "goat", "hedgehog", "iguana"]
//
//println("Original: \(organisms)")
//
//organisms.shuffle()
//
//println("Shuffled: \(organisms)")
