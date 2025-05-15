//
//  JsonService.swift
//  AuthAndMessages
//
//  Created by Mangust on 16.05.2025.
//

import Foundation

struct JsonService {
    func get(from path: String) async -> String? {
        return """
[
  {
    "id": "50da0479-10e5-4e86-8cf8-3bb78c3ce40b",
    "title": "Beastmaster",
    "text": "Definitions are important.",
    "image": "https://previeweu.thenewsmarket.com/Previews/NonAssetImages/MR_792/Custom/b7bfe539-748e-4365-aade-0fecb44e67b9.jpg",
    "sort": -6,
    "date": "2025-05-15T16:35:13Z"
  },
  {
    "id": "b601666e-23f1-4a61-ba8a-0d5ce6db437d",
    "title": "Bristleback",
    "text": "We’re going to get older whether we like it or not, so the only question is whether we get on with our lives, or desperately cling to the past.",
    "image": "https://previeweu.thenewsmarket.com/Previews/NonAssetImages/MR_792/Custom/9090a5e2-0ec1-4863-9f89-90ca136c491e.jpg",
    "sort": -7,
    "date": "2025-05-14T11:33:41Z"
  },
  {
    "id": "32b0fcea-2d31-4bce-be5d-e1edf5f6d242",
    "title": "Chaos Knight",
    "text": "Definitions are important.",
    "image": "https://previeweu.thenewsmarket.com/Previews/NonAssetImages/MR_792/Custom/8f2b0903-5011-40f4-b31d-9cb358f40d26.jpg",
    "sort": -7,
    "date": "2025-05-14T11:30:29Z"
  },
  {
    "id": "09b37139-f7da-4f33-ba4e-9bb4d4899de0",
    "title": "Axe",
    "text": "Revenge fantasies never work out the way you want.",
    "image": "https://previeweu.thenewsmarket.com/Previews/NonAssetImages/MR_792/Custom/0bd3d25d-709b-4890-8118-322bf26030fd.jpg",
    "sort": -7,
    "date": "2025-05-14T11:27:13Z"
  },
  {
    "id": "287ad3bc-d38e-4cd2-bbf2-1371394bdf0a",
    "title": "Centaur Warrunner",
    "text": "There are two big days in any love story: the day you meet the girl of your dreams and the day you marry her.",
    "image": "https://previeweu.thenewsmarket.com/Previews/NonAssetImages/MR_792/Custom/bfd56113-88c4-4c1c-8bb5-3ee296bf769e.jpg",
    "sort": -7,
    "date": "2025-05-14T11:24:10Z"
  },
  {
    "id": "7a9efbb4-0134-49d9-9000-82a08b0c7609",
    "title": "Clockwerk",
    "text": "You can’t just skip ahead to where you think your life should be.",
    "image": "https://previeweu.thenewsmarket.com/Previews/NonAssetImages/MR_792/Custom/403d1ea8-3f02-45b0-ae49-3b7dfafd0825.jpg",
    "sort": -7,
    "date": "2025-05-14T11:24:06Z"
  },
  {
    "id": "312d01f8-f65d-48aa-95c7-b97b6fd93f95",
    "title": "Alchemist",
    "text": "Whether a gesture’s charming or alarming, depends on how it’s received.",
    "image": "https://previeweu.thenewsmarket.com/Previews/NonAssetImages/MR_792/Custom/938ae013-5f63-4281-b842-237f2d47d28f.jpg",
    "sort": -7,
    "date": "2025-05-14T11:23:36Z"
  },
  {
    "id": "60eb6f0b-2db8-48f0-86a8-139b524a0a5a",
    "title": "Clockwerk",
    "text": "Revenge fantasies never work out the way you want.",
    "image": "https://previeweu.thenewsmarket.com/Previews/NonAssetImages/MR_792/Custom/144f97f0-b730-4a6c-a21e-eb0dbeb6d88e.jpg",
    "sort": -7,
    "date": "2025-05-14T10:54:23Z"
  },
  {
    "id": "dac55686-0ea1-4c16-a3b3-e840d8028720",
    "title": "Abaddon",
    "text": "Look, you can’t design your life like a building. It doesn’t work that way. You just have to live it… and it’ll design itself.",
    "image": "https://previeweu.thenewsmarket.com/Previews/NonAssetImages/MR_792/Custom/3bbfb5b1-62dd-40ab-893b-f9a154e33ae4.jpg",
    "sort": -7,
    "date": "2025-05-14T10:54:11Z"
  },
  {
    "id": "65b58478-5951-4c5e-bce7-aef2bcf219af",
    "title": "Alchemist",
    "text": "That’s life, you know, we never end up where you thought you wanted to be.",
    "image": "https://previeweu.thenewsmarket.com/Previews/NonAssetImages/MR_792/Custom/dc75d650-519e-4294-9926-bdca712e8794.jpg",
    "sort": -7,
    "date": "2025-05-14T06:50:58Z"
  }
]
"""
    }
}
