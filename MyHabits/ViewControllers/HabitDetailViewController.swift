//
//  HabitDetailViewController.swift
//  MyHabits
//
//  Created by  User on 25.08.2023.
//

import UIKit

private let cellID = "tableCell"

class HabitDetailViewController: UIViewController {
    
    private var tableView: UITableView!
    var habit: Habit!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView = UITableView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        navigationItem.title = habit.name
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(toDoEdit(_ :)))
    }
    
    @objc func toDoEdit(_ sender: UIBarButtonItem) {
        let vc = HabitViewController()
        vc.habit = habit
        vc.hidesBottomBarWhenPushed = true
        vc.habitState = .edit
        navigationController?.pushViewController(vc, animated: true)
    }

    

}

extension HabitDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let date = HabitsStore.shared.dates[indexPath.item]
        cell.textLabel?.text = date.toString()
        if HabitsStore.shared.habit(habit, isTrackedIn: date){
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

extension Date {
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    var dayBeforeYesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    func get() -> Int {
        return Calendar.current.component(.day, from: self)
    }
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_Ru")
        formatter.dateFormat = "dd MMMM YYYY"
        
        
        
        let d = Date()
        let day = get()
        let today = d.get()
        let yesterday = d.dayBefore.get()
        let dayBeforeYesterday = d.dayBeforeYesterday.get()
        
        switch day {
        case today:
            return "Сегодня"
        case yesterday:
            return "Вчера"
        case dayBeforeYesterday:
            return "Позавчера"
        default:
            return formatter.string(from: self)
        }
        
        
    }
    
}

