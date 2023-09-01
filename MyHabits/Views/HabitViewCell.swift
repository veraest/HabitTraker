//
//  HabitViewCell.swift
//  MyHabits
//
//  Created by  User on 24.08.2023.
//

import UIKit

class HabitViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var stateButton: UIButton!
    
    private var habit: Habit!
    private var clickOnStateButton: (() -> Void)!
    
    let checkedImage = UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysTemplate)
    let uncheckedImage = UIImage(systemName: "circle")?.withRenderingMode(.alwaysTemplate)

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        self.contentView.layer.cornerRadius = 8
        
    }
    
    func setupCell(with habit: Habit, clickOnStateButton: @escaping () -> Void) {
        self.habit = habit
        self.clickOnStateButton = clickOnStateButton
        
        self.titleLabel.text = habit.name
        self.titleLabel.textColor = habit.color
        self.subTitleLabel.text = habit.dateString
        self.counterLabel.text = "Счетчик \(habit.trackDates.count)"
        
        if habit.isAlreadyTakenToday{
            self.stateButton.setImage(checkedImage, for: .normal)
        }else{
            self.stateButton.setImage(uncheckedImage, for: .normal)
        }
        self.stateButton.tintColor = habit.color
    }
    
    @IBAction func stateButtonTaped(sender: UIButton) {
        if !habit.isAlreadyTakenToday{
            self.stateButton.setImage(checkedImage, for: .normal)
            HabitsStore.shared.track(habit)
            self.clickOnStateButton()
        }
    }

}
