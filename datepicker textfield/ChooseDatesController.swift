//
//  ChooseDatesController.swift
//  EyaalZayeed
//
//  Created by apple on 04/07/17.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

protocol UIChooseDatePickerDataDelegate {
    
    func getStartAndEndDates(startDate :String?,endDate: String?)
}

class ChooseDatesController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var containerBottomSpace: NSLayoutConstraint!
    
    @IBOutlet weak var startDateTextField: EZTextField!
    @IBOutlet weak var endDateTextField: EZTextField!
    @IBOutlet weak var applyButton: EZButton!
    @IBOutlet weak var applyButtonTrailingSpace: NSLayoutConstraint!
    
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var todayLabel: UILabel!
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var resetButtonImage: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var toolBarView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var isStartDate:Bool!
    
    var selectedStartDate:String?
    var selectedEndDate:String?
    var selectedIndex: Int = 0
    
    
    var minimumDate: Date?
    var maximumDate: Date?
    var todaysDate:Date?
    
    
    
    var currentViewController : String =  String()
    var targetViewController :UIViewController?
    var delegate:UIChooseDatePickerDataDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialUISetup()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        initialUISetup()
        
    }
    
    func initialUISetup()
    {
        self.automaticallyAdjustsScrollViewInsets =  false
        self.navigationController?.navigationBar.isHidden =  true
        containerView.setCardView(view: containerView)
        pickerContainerView.isHidden =  true
        
        startDateTextField.leftImage =  UIImage(named: "calender")
        endDateTextField.leftImage = UIImage(named: "calender")
        
        startDateTextField.rightImage =  UIImage(named: "down_arrow")
        endDateTextField.rightImage =  UIImage(named: "down_arrow")
        
        disableApplyButton()
        //showResetButton()
        hideTodayButton()
        setMaximumDate()
        
        
    }
    func setMaximumDate()
    {
        let date = NSDate()
        datePicker.maximumDate = date as Date
    }
    
    func enableApplyButton()
    {
        applyButton.isEnabled = true
        applyButton.alpha = 1.0
        applyButtonTrailingSpace.constant = 70.0
        showResetButton()
    }
    func disableApplyButton()
    {
        applyButton.isEnabled = false
        applyButton.alpha = 0.4
        applyButtonTrailingSpace.constant = 20.0
        hideResetButton()
        
    }
    func hideTodayButton()
    {
        todayButton.isEnabled = false
        todayLabel.isHidden =  true
        
    }
    func showTodayButton()
    {
        todayButton.isEnabled =  true
        todayLabel.isHidden =  false
        
    }
    func showResetButton()
    {
        resetButtonImage.isHidden =  false
        resetButton.isEnabled =  true
        
    }
    func hideResetButton()
    {
        resetButtonImage.isHidden =  true
        resetButton.isEnabled =  false
        
    }
    
    //TextField Delegates
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            isStartDate = true
            hideTodayButton()
        case 1:
            isStartDate = false
            showTodayButton()
        default:
            break
        }
        
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.resignFirstResponder()
        scrollMenuBoxUp()
        makeTextFieldsInactive()
        pickerContainerView.setViewAnimted(view: pickerContainerView, hidden: false)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    func scrollMenuBoxUp() {
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.autoreverse,animations: {
            self.containerBottomSpace.constant = 60.0
            
        },completion: { finished in
            
        })
        
    }
    func resetMenuBoxPosition() {
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.autoreverse,animations: {
            self.containerBottomSpace.constant = 0.0
            
        },completion: { finished in
            
        })
        
    }
    func makeTextFieldsActive()    {
        startDateTextField.isEnabled =  true
        endDateTextField.isEnabled =  true
    }
    func makeTextFieldsInactive()    {
        startDateTextField.isEnabled =  false
        endDateTextField.isEnabled =  false
    }
    func clearTextFieldData()    {
        clearStartDate()
        clearEndDate()
        
        disableApplyButton()
        
    }
    func clearStartDate()
    {
        startDateTextField.text = ""
        selectedStartDate = nil
    }
    func clearEndDate()
    {
        endDateTextField.text = ""
        selectedEndDate = nil
    }
    
    //Picker Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    @IBAction func cancelPicker(_ sender: Any) {
        
        pickerContainerView.setViewAnimted(view: pickerContainerView, hidden: true)
        resetMenuBoxPosition()
        makeTextFieldsActive()
    }
    @IBAction func donePicker(_ sender: Any) {
        
        switch isStartDate {
        case true:
            startDateTextField.text = selectedStartDate
            break
        case false:
            endDateTextField.text = selectedEndDate
            break
        default :
            break
        }
        
        if (selectedStartDate != nil && selectedEndDate != nil)
        {
            enableApplyButton()
         
        }
        else {
            disableApplyButton()
           
        }
        
        pickerContainerView.setViewAnimted(view: pickerContainerView, hidden: true)
        resetMenuBoxPosition()
        makeTextFieldsActive()
    }
    @IBAction func datePickerValueChanged(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        switch isStartDate {
        case true:
            selectedStartDate = dateFormatter.string(from: (sender as AnyObject).date)
            break
        case false:
            selectedEndDate = dateFormatter.string(from: (sender as AnyObject).date)
            break
        default :
            break
        }
        
    }
    
    @IBAction func applyButtonClicked(_ sender: Any) {
        
        self.delegate.getStartAndEndDates(startDate: self.startDateTextField.text, endDate: self.endDateTextField.text)
        
        self.dismiss(animated: true)
        
    }
    @IBAction func todayButtonClicked(_ sender: Any) {
        
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = DateFormatter.Style.medium
        dateformatter.timeStyle = DateFormatter.Style.none
        selectedEndDate = dateformatter.string(from: Date())
        endDateTextField.text = selectedEndDate
        
        print("selectedEndDate : \(selectedEndDate)")
        
        pickerContainerView.setViewAnimted(view: pickerContainerView, hidden: true)
        resetMenuBoxPosition()
        makeTextFieldsActive()
        
    }
    @IBAction func resetButtonClicked(_ sender: Any) {
        
        clearTextFieldData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
