//
//  ViewController.swift
//  SimpleHTTPClient1
//

import UIKit



class ViewController: UIViewController {
    
    let claimField = UITextField()
    let dateField = UITextField()
    let statusVariable = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainView = UIStackView()
        mainView.axis = .vertical
        mainView.distribution = .fillEqually
        
        let titleRow = UIStackView()
        
        let claimRow = UIStackView()
        claimRow.distribution = .fillEqually
        
        let dateRow = UIStackView()
        dateRow.distribution = .fillEqually
        
        let buttonRow = UIStackView()
        
        let statusRow = UIStackView()
                
        let mainTitle = UILabel()
        let claimTitle = UILabel()
        let dateLabel = UILabel()
        let statusLabel = UILabel()
        
        
        mainTitle.text = "Please Enter Claim Information"
        claimTitle.text = "Claim Title"
        dateLabel.text = "Date"
        statusLabel.text = "Status: "
        statusVariable.text = "<Status Message>"
        
        let submitButton = UIButton()
        submitButton.backgroundColor = .black
        submitButton.setTitle("Add", for: .normal)
        submitButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        claimField.placeholder = "This is a test"
        claimField.borderStyle = UITextField.BorderStyle.roundedRect
        claimField.keyboardType = UIKeyboardType.default
        claimField.returnKeyType = UIReturnKeyType.done
        claimField.autocorrectionType = UITextAutocorrectionType.no
        
        dateField.placeholder = "This is a test"
        dateField.borderStyle = UITextField.BorderStyle.roundedRect
        dateField.keyboardType = UIKeyboardType.default
        dateField.returnKeyType = UIReturnKeyType.done
        dateField.autocorrectionType = UITextAutocorrectionType.no
        
        titleRow.addArrangedSubview(mainTitle)
        
        claimRow.addArrangedSubview(claimTitle)
        claimRow.addArrangedSubview(claimField)
        
        dateRow.addArrangedSubview(dateLabel)
        dateRow.addArrangedSubview(dateField)
        
        buttonRow.addArrangedSubview(submitButton)
        
        statusRow.addArrangedSubview(statusLabel)
        statusRow.addArrangedSubview(statusVariable)
        
        mainView.addArrangedSubview(titleRow)
        mainView.addArrangedSubview(claimRow)
        mainView.addArrangedSubview(dateRow)
        mainView.addArrangedSubview(buttonRow)
        mainView.addArrangedSubview(statusRow)
        view.addSubview(mainView)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        let spCnt1 = mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        
        spCnt1.isActive = true
        
    }
    
    @objc func buttonClicked()
    {
        let claimVariable = claimField.text
        let dateVariable = dateField.text

        if(claimVariable != "" && dateVariable != "") {
            let pService = ClaimService()
            
            pService.addClaim(pObj: Claim(this_title: claimVariable!, this_date: dateVariable!))
            
            pService.getAll()
            let pList = pService.ClaimList
            var exists = false
            
            claimField.text = ""
            dateField.text = ""
            
            for i in 0...pList.count {
                if (pList[i].title == claimVariable) {
                    exists = true
                }
            }
            
            if (exists == true) {
                statusVariable.text = "Claim " + claimVariable! + " was successfully created"
            }
            else {
                statusVariable.text = "Claim " + claimVariable! + " failed to be created"
            }
        }
        else {
            statusVariable.text = "Claim " + claimVariable! + " failed to be created"
        }
        
        
    }
}

