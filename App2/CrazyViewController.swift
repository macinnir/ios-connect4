//
//  CrazyViewController.swift
//  App2
//
//  Created by Robert MacInnis on 8/8/23.
//

import UIKit

let cols : CGFloat = 7
let rows : CGFloat = 6

class CrazyViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var crazyTabItem: UITabBarItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var turnImage: UIImageView!
    
    @IBOutlet weak var yellowScoreLabel: UILabel!
    @IBOutlet weak var redScoreLabel: UILabel!
    
    var redScore = 0
    var yellowScore = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        resetBoard()
        
        setCellWidthHeight()
        
        setupScoreboard()
        
    }
    
    func setupScoreboard() {
        
        let cornerRadius : CGFloat = 30.0
        let fontSize : CGFloat = 50.0
        let height : CGFloat = 60.0
        
        yellowScoreLabel.layer.cornerRadius = cornerRadius
        yellowScoreLabel.textAlignment = .center
//        yellowScoreLabel.layer.borderWidth = 10
        yellowScoreLabel.layer.backgroundColor = UIColor.systemYellow.cgColor
        yellowScoreLabel.font = UIFont(name: "Hoefler Text", size: fontSize)
        yellowScoreLabel.text = "0"
        yellowScoreLabel.frame.size.height = height
        yellowScoreLabel.frame.size.width = height
        
        redScoreLabel.layer.cornerRadius = cornerRadius
        redScoreLabel.textAlignment = .center
//        redScoreLabel.layer.borderWidth = 10
        redScoreLabel.layer.backgroundColor = UIColor.red.cgColor
        redScoreLabel.font = UIFont(name: "Hoefler Text", size: fontSize)
        redScoreLabel.text = "0"
        redScoreLabel.frame.size.height = height
        redScoreLabel.frame.size.width = height
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(CrazyViewController.onYellowScoreClick)
        )
        yellowScoreLabel.isUserInteractionEnabled = true
        yellowScoreLabel.addGestureRecognizer(tap)
    }
    
    func setCellWidthHeight() {
        
        let width = collectionView.frame.size.width / cols
        
        let height = collectionView.frame.size.height / rows
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        flowLayout.itemSize = CGSize(
            width : width,
            height: height
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        crazyTabItem.badgeValue = nil
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return board.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return board[section].count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idCell", for: indexPath) as! BoardCell
        
        let boardItem = getBoardItem(indexPath)
        
        cell.Image.tintColor = boardItem.tileColor()
        
        // Make the image transparent
        cell.Image.alpha = 0
        
        //
        cell.transform = CGAffineTransform(
            scaleX: 1,
            y: 0
        )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("didSelectItemAt???")
        
        let column = indexPath.item
        if var boardItem = getLowestEmptyBoardItemInColumn(column)
        {
            if let cell = collectionView.cellForItem(at : boardItem.indexPath) as? BoardCell
            {
                cell.Image.tintColor = currentTurnColor()
                boardItem.tile = currentTurnTile()
                updateBoardWithBoardItem(boardItem)
                
                
                if victoryAchieved()
                {
                    if yellowTurn()
                    {
                        yellowScore += 1
                        yellowScoreLabel.text = "\(yellowScore)"
                        animateScoreLabel(yellowScoreLabel)

                    }
                    else
                    {
                        redScore += 1
                        redScoreLabel.text = "\(redScore)"
                        animateScoreLabel(redScoreLabel)
                    }
                    
                    resultAlert(currentTurnVictoryMessage())
                    
                }
                
                if boardIsFull()
                {
                    resultAlert("Draw")
                }
                
                toggleTurn(turnImage)
            }
        }
    }
    
    let animationDuration: Double = 0.5
    let delayBase: Double = 0.1
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        // They all come in at the same time
//        let delay : Double = 1
        let trueIndex = Double((indexPath.row) + indexPath.section)
//        let delay = sqrt(trueIndex)
        
//        let delay = sqrt(Double(indexPath.item)) * delayBase
        
        // section == row
        // row == column
        
        let left = indexPath.row
        let top = indexPath.section
        let distance = left > top ? left : top
        
        

        
//        let column = Double(indexPath.section % Int(cols))
//        let row = floor(Double(indexPath.section / Int(cols)))
//        let distance = sqrt(pow(column, 2)) + pow(row, 2)
//        let delay = trueIndex / 10 // sqrt(distance) / 4
        
        print("distance: \(distance), row: \(indexPath.section), column: \(indexPath.row) -> \(trueIndex)")
        
        UIView.animate(
            withDuration: animationDuration,
            delay: sqrt(Double(distance) / 10),
            options: .curveEaseOut
        ) {
        
//            if indexPath.section == 5 && indexPath.row == 5 {
//                return
//            }
            
            if let cell = cell as? BoardCell
            {
                cell.Image.alpha = 1
                cell.transform = .identity
                
            }
//            if let cell = collectionView.cellForItem(at : indexPath) as? BoardCell
//            {
//                cell.Image.alpha = 1
//            }
        }
    }
    
    func resultAlert(_ title : String)
    {
        let message = "\nRed: " + String(redScore) + "\n\nYellow: " + String(yellowScore)
        let ac = UIAlertController(
            title : title,
            message : message,
            preferredStyle: .actionSheet
        )
        
        ac.addAction(UIAlertAction(title : "Reset", style : .default, handler: {
            [self] (_) in
            resetBoard()
            self.resetCells()
        }))
        
        self.present(ac, animated: true)
    }
    
    func resetCells()
    {
        for cell in collectionView.visibleCells as! [BoardCell]
        {
            cell.Image.tintColor = .white
        }
    }
    
    @objc func onYellowScoreClick(sender : UITapGestureRecognizer)
    {
        animateScoreLabel(yellowScoreLabel)
    }
    
    func animateScoreLabel(_ label: UILabel)
    {
        
        UIView.animateKeyframes(
            
            withDuration: 1.0,
            delay: 0.0,
            options: [],
            animations: {
                
//                UIView.addKeyframe(
//                    withRelativeStartTime: 0.0,
//                    relativeDuration: 0.25,
//                    animations: {
//                        label.center = self.view.center
//                    }
//                )
                
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 1,
                    animations: {
                        let transformation =  CGAffineTransform(rotationAngle: 180)
                        let scale = CGAffineTransform(scaleX: 1.5, y: 1.5)
                        
                        
                        label.transform = transformation.concatenating(scale)
                    }
                )
                
                UIView.addKeyframe(
                    withRelativeStartTime: 0.33,
                    relativeDuration: 1,
                    animations: {
                        let transformation = CGAffineTransform(rotationAngle: 0)
                        let scale = CGAffineTransform(scaleX: 1, y: 1)
                        label.transform = transformation.concatenating(scale)
                    }
                )
                
//                UIView.addKeyframe(
//                    withRelativeStartTime: 0.66,
//                    relativeDuration: 0.25,
//                    animations: {
//                        label.center = CGPoint(x: self.view.frame.width + 100, y: label.frame.midY)
//                    }
//                )
        }
        )

    }
    
    
}

