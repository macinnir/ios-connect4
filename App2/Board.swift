//
//  Board.swift
//  App2
//
//  Created by Robert MacInnis on 8/10/23.
//

import UIKit

// Global board object
// 2 dimensional array of BoardItems
var board = [[BoardItem]]()

func resetBoard()
{
    board.removeAll()
    
    for row in 0...(Int(rows) - 1)
    {
        var rowArray = [BoardItem]()
        for column in 0...(Int(cols) - 1)
        {
            let indexPath = IndexPath.init(row: column, section : row)
            let boardItem = BoardItem(indexPath : indexPath, tile : Tile.Empty)
            rowArray.append(boardItem)
        }
     
        board.append(rowArray)        
    }
}

func getBoardItem(_ indexPath : IndexPath) -> BoardItem 
{
    return board[indexPath.section][indexPath.item]
}

// Travel from the bottom of a column and return the first cell that is empty
// Return nil if column has no empty cells
func getLowestEmptyBoardItemInColumn(_ column: Int) -> BoardItem?
{
    // Traverse backwards through the rows in column `column` to find an empty cell
    for row in (0...(Int(rows) - 1)).reversed()
    {
        let boardItem = board[row][column]
        if boardItem.emptyTile()
        {
            return boardItem
        }
    }
    
    // Not found
    return nil
}

func updateBoardWithBoardItem(_ boardItem : BoardItem)
{
    if let indexPath = boardItem.indexPath
    {
        board[indexPath.section][indexPath.item] = boardItem 
    }
}

func boardIsFull() -> Bool
{
    for row in board
    {
        for col in row
        {
            if col.emptyTile()
            {
                return false
            }
        }
    }
    
    return true
}

func victoryAchieved() -> Bool
{
    return horizontalVictoryAchieved() || verticalVictoryAchieved() || diagnolVictoryAchieved()
}


func horizontalVictoryAchieved() -> Bool
{
    var n = 0
    for row in board
    {
        for col in row
        {
            if col.tile == currentTurnTile()
            {
                n += 1
                if n >= 4
                {
                    return true
                }
            }
            else
            {
                n = 0
            }
        }
        n = 0
    }
    
    return false
}

func verticalVictoryAchieved() -> Bool
{
    for colIndex in 0...(Int(cols) - 1)
    {
        var n = 0
        for rowIndex in 0...(Int(rows) - 1)
        {
            if board[rowIndex][colIndex].tile == currentTurnTile() {
                n += 1
                
                if n >= 4
                {
                    return true
                }
            }
            else
            {
                n = 0
            }
        }
    }
    
    return false
}


func diagnolVictoryAchieved() -> Bool
{
    for column in 0...board.count
    {
        if checkDiagnolColumn(column, true, true)
        {
            return true
        }
        
        if checkDiagnolColumn(column, true, false)
        {
            return true
        }
        
        if checkDiagnolColumn(column, false, true)
        {
            return true
        }
        
        if checkDiagnolColumn(column, false, false)
        {
            return true
        }
    }
    
    return false
}

func checkDiagnolColumn(_ columnToCheck : Int, _ moveUp : Bool, _ reverseRows: Bool) -> Bool
{
    var movingColumn = columnToCheck
    var consecutive = 0
    
    let boardToSearch = reverseRows ? board.reversed() : board
    
    for row in boardToSearch
    {
        // if the column isn't at the end
        if movingColumn >= 0 && movingColumn < row.count
        {
            if row[movingColumn].tile == currentTurnTile()
            {
                consecutive += 1
                
                if consecutive >= 4
                {
                    return true
                }
            }
            else
            {
                consecutive = 0
            }
            
            movingColumn = moveUp ? movingColumn + 1 : movingColumn - 1
        }
    }
    
    return false
}
