//
//  InfoViewController.swift
//  MyHabits
//
//  Created by  User on 23.08.2023.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "dBackground")
        self.navigationItem.title = "Информация"
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        
        let firstString = NSAttributedString(string: "Привычка за 21 день\n\n",       attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let secondString = NSAttributedString(string:
         """
         Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется
         следующему алгоритму:
         
         1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.
              
         2. Выдержать 2 дня в прежнем состоянии самоконтроля.
             
         3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.
              
         4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.
              
         5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.
         
         6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.
         """, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let result = NSMutableAttributedString()
        result.append(firstString)
        result.append(secondString)
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.attributedText = result
        textView.textAlignment = .left
        
        
        self.view.addSubview(textView)
        
        textView.textContainerInset = UIEdgeInsets(top: 22, left: 16, bottom: 0, right: 16)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
        
    }
    

    
}
