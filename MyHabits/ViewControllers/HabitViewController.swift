//
//  HabitViewController.swift
//  MyHabits
//
//  Created by  User on 24.08.2023.
//

import UIKit

enum HabitVCState {
    case create, edit
}

@available(iOS 14.0, *)

class HabitViewController: UIViewController {
    
    var habit: Habit?
    var habitState: HabitVCState = .create
    var guide: UILayoutGuide!
    private var titleLabel: UILabel!
    private var titleTextField: UITextField!
    private var colorButtonLabel: UILabel!
    private var colorButton: UIButton!
    private var dateLabel: UILabel!
    private var datePickerLabel: UILabel!
    private var datePicker: UIDatePicker!
    private var deleteHabitButton: UIButton!
    
    private var currentTitle: String = ""
    private var currentColor: UIColor = .orange
    private var currentDate: Date = Date()
    private let picker = UIColorPickerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "dBackground")
        
        if let habit {
            currentDate = habit.date
            currentColor = habit.color
            currentTitle = habit.name
        }
        
        
        setupViews()
        setupNavigationController()
    }
    
    func setupNavigationController() {
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(goBack(_ :)))
        self.navigationItem.title = self.habitState == .create ? "Создать" : "Править"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveHabit(_ :)))
    }
    
    
    func setupViews() {
        guide = view.safeAreaLayoutGuide
        self.picker.delegate = self
        self.picker.selectedColor = currentColor
        createTitleLabel()
        createTitleTF()
        createColorButtonLabel()
        createColorButton()
        createDateLabel()
        createDatePickerLabel()
        createDatePicker()
        if habitState == .edit{
            createDeleteButton()
        }
             
    }
    
    @objc func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveHabit(_ sender: UIBarButtonItem) {
        if self.habitState == .create {
            HabitsStore.shared.habits.append(
                Habit(name: currentTitle, date: currentDate, color: currentColor)
            )
            self.navigationController?.popViewController(animated: true)        }else{
            let hab = HabitsStore.shared.habits.first{
                $0 == habit
            }
            if let hab{
                hab.name = currentTitle
                hab.date = currentDate
                hab.color = currentColor
            }
            let vcs = self.navigationController!.viewControllers
            self.navigationController?.popToViewController(vcs[vcs.count - 3], animated: true)
        }
        
    }
    
    func createColorButtonLabel() {
        colorButtonLabel = UILabel()
        colorButtonLabel.text = "Цвет"
        colorButtonLabel.font = colorButtonLabel.font.withSize(13)
        colorButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(colorButtonLabel)
        
        NSLayoutConstraint.activate([
            colorButtonLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            colorButtonLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            
        ])
        
    }
    
    func createColorButton() {
        let colorImage = UIImage(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))!.withRenderingMode(.alwaysTemplate)
        colorButton = UIButton()
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(colorButton)
        colorButton.setImage(colorImage, for: .normal)
        colorButton.tintColor = currentColor
        colorButton.addTarget(self, action: #selector(showPicher(_ :)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            colorButton.topAnchor.constraint(equalTo: colorButtonLabel.bottomAnchor, constant: 7),
            colorButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16)
            
        ])
        
    }
    
    @objc func showPicher(_ sender: UIButton) {
        self.present(picker, animated: true)
    }
    
    func createDateLabel() {
        dateLabel = UILabel()
        dateLabel.text = "Время"
        dateLabel.font = dateLabel.font.withSize(13)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 15),
            dateLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
        ])
        
    }
    
    func createDatePickerLabel() {
        datePickerLabel = UILabel()
        let dateString = currentDate.formatted(date: .omitted, time: .shortened)
        setTextDatePickerLabel(with: dateString)
        datePickerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(datePickerLabel)
        
        NSLayoutConstraint.activate([
            datePickerLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 7),
            datePickerLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            
        ])
    }
    
    func setTextDatePickerLabel(with value: String) {
        let mutableString = NSMutableAttributedString(string: "Каждый день в \(value)")
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(named: "dPurple")! , range: NSRange(location: 12, length: value.count + 2))
        self.datePickerLabel.attributedText = mutableString
    }
    
    func createDatePicker() {
        datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        datePicker.addTarget(self, action: #selector(setCurrentTime(_ :)), for: .valueChanged)
        self.view.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: datePickerLabel.bottomAnchor, constant: 15),
            datePicker.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: guide.trailingAnchor)
        ])
    }
    
    @objc func setCurrentTime(_ sender: UIDatePicker) {
        self.currentDate = sender.date
        setTextDatePickerLabel(with: sender.date.formatted(date: .omitted, time: .shortened))
    }
    
    func createDeleteButton() {
        deleteHabitButton = UIButton()
        deleteHabitButton.translatesAutoresizingMaskIntoConstraints = false
        deleteHabitButton.setTitle("Удалить привычку", for: .normal)
        deleteHabitButton.setTitleColor(.red, for: .normal)
        deleteHabitButton.addTarget(self, action: #selector(showDeleteAlert(_ :)), for: .touchUpInside)
        self.view.addSubview(deleteHabitButton)
        
        NSLayoutConstraint.activate([
            deleteHabitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            deleteHabitButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40),
        ])
    }
    
    @objc func showDeleteAlert(_ sender: UIButton) {
        let deleteAlert = UIAlertController(title: "Удалить привычку", message: "Вы уверены, что хотите удалить привычку \(habit!.name)?", preferredStyle: .alert)
        deleteAlert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        deleteAlert.addAction(UIAlertAction(title: "Удалить", style: .destructive){ _ in
            HabitsStore.shared.habits.removeAll{
                $0 == self.habit
            }
            let vcs = self.navigationController!.viewControllers
            self.navigationController?.popToViewController(vcs[vcs.count-3], animated: true)
        })
        self.present(deleteAlert, animated: true)
    }}

extension HabitViewController: UITextFieldDelegate{
    
    func createTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Название"
        titleLabel.font = titleLabel.font.withSize(13)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 21),
            titleLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            
        ])
    }
    
    func createTitleTF() {
        titleTextField = UITextField()
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.placeholder = "Выгулять собак, покормить кота, полить цветы и т. д."
        titleTextField.text = currentTitle
        titleTextField.delegate = self
        self.view.addSubview(titleTextField)
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            titleTextField.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 15),
            titleTextField.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: 15)
        ])
        
        
    }
    
    func  textFieldDidChangeSelection(_ textField: UITextField) {
        self.currentTitle = textField.text ?? ""
    }
    
    
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        dismiss(animated: true)
    }
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        self.colorButton.tintColor = currentColor
        self.currentColor = color
        print("Done")
        
    }
}
