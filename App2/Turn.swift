//
//  Turn.swift
//  App2
//
//  Created by Robert MacInnis on 8/10/23.
//

import UIKit

enum Turn
{
    case Red
    case Yellow
}

var currentTurn = Turn.Yellow

func toggleTurn(_ turnImage : UIImageView)
{
    if yellowTurn()
    {
        currentTurn = .Red
        turnImage.tintColor = .red
    }
    else
    {
        currentTurn = .Yellow
        turnImage.tintColor = .systemYellow
    }
}

func yellowTurn() -> Bool
{
    return currentTurn == Turn.Yellow
}

func redTurn() -> Bool
{
    return currentTurn == Turn.Red
}

func currentTurnTile() -> Tile
{
    return yellowTurn() ? Tile.Yellow : Tile.Red
}

func currentTurnColor() -> UIColor
{
    return yellowTurn() ? .systemYellow : .red
}

func currentTurnVictoryMessage() -> String
{
    return yellowTurn() ? "Yellow Wins!" : "Red Wins!"
}
