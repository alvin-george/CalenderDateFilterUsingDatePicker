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
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var toolBarView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var isStartDate:Bool!
    
    var selectedStartDate:String?
    var selectedEndDate:String?
    var selectedIndex: Int = 0
    
    
    
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
        
        
    }
    func enableApplyButton()
    {
        applyButton.isEnabled = true
        applyButton.alpha = 1.0
    }
    func disableApplyButton()
    {
        applyButton.isEnabled = false
        applyButton.alpha = 0.4
        
    }
    //TextField Delegates
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            isStartDate = true
        case 1:
            isStartDate = false
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
    func clearTextFieldData()
    {
        startDateTextField.text = ""
        endDateTextField.text = ""
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
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch isStartDate {
        case true:
            //self.selectedStartDate =
            break
        case false:
            //self.selectedEndDate
            break
        default :
            break
        }
        
        selectedIndex = row
    }
    
    @IBAction func cancelPicker(_ sender: Any) {
        
        switch isStartDate {
        case true:
           clearStartDate()
            break
        case false:
            clearEndDate()
            
            break
        default :
            break
        }
        //self.delegate.datePickerDismissed(isDismissed: true)
        
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
        
        print("selectedStartDate :\(selectedStartDate) && selectedEndDate : \(selectedEndDate)")
        
        //self.delegate.datePickerDismissed(isDismissed: true)
        
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
    
    func getTodaysDate(_ sender: UIButton) {
        
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = DateFormatter.Style.medium
        dateformatter.timeStyle = DateFormatter.Style.none
        
        //dateTextField.text = dateformatter.string(from: Date())
        
        //dateTextField.resignFirstResponder()
        
    }
    @IBAction func applyButtonClicked(_ sender: Any) {
        
        self.delegate.getStartAndEndDates(startDate: self.startDateTextField.text, endDate: self.endDateTextField.text)
        
        self.dismiss(animated: true)
        
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
