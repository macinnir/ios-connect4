//
//  BoardItem.swift
//  App2
//
//  Created by Robert MacInnis on 8/10/23.
//

import UIKit

enum Tile {
    case Red
    case Yellow
    case Empty
}

struct BoardItem
{
    var indexPath : IndexPath!
    var tile : Tile!
    
    func yellowTile() -> Bool
    {
        return tile == Tile.Yellow
    }
    
    func redTile() -> Bool
    {
        return tile == Tile.Red
    }
    
    func emptyTile() -> Bool
    {
        return tile == Tile.Empty
    }
    
    func tileColor() -> UIColor
    {    
        if(redTile())
        {
            return .red
        }
        
        if(yellowTile())
        {
            return .systemYellow
        }
        
        // Empty tile
        return .white
    }
}
