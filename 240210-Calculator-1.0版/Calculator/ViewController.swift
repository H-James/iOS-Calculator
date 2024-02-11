//
//  ViewController.swift
//  Calculator
//
//  Created by James Liu on 2024/2/5.
//

import Cocoa
import Foundation
import AudioToolbox

class ViewController: NSViewController {

    @IBOutlet weak var screen: NSTextField!
    @IBOutlet weak var clearButton: NSButton!
    
    var alertSound: SystemSoundID = 0
    
    var backup_number_1 = "empty"
    var backup_theOperator = "empty"
    var number_1: String = "0"
    var theOperator: String = "+"
    var number_2: String = "0"
    
    //这个变量用来标记当前哪一个数字容器用于显示和修改
    var focusNumber: String = "number_1"
    
    //这个变量用来标记number_2中的数据是用户在最近的一个操作中输入的。注意！按下任何一个按键都算是一个操作。
    var number_2_inputFromUser: Bool = false

    //这个变量用来标记最近按下的按钮属于一个特定功能性按键。因为我们需要在按下特定功能性按键后，如果紧接着输入数字，程序应该清空容器内的数据后，再降数字装载进容器。
    var shouldClearScreen: Bool = false
    
    //这个变量用来标记备用容器是否被打开
    var backupGroupIsOpen: Bool = false
    
    // MARK: - 初始化
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 加载系统自带的警告音
        if let soundURL = Bundle.main.url(forResource: "alert", withExtension: "caf") {
            let result = AudioServicesCreateSystemSoundID(soundURL as CFURL, &alertSound)
            if result != 0 {
                print("Error creating system sound ID: \(result)")
            }
        } else {
            print("Error loading sound file.")
        }
        refreshDisplay()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    // MARK: - 按下数字

    @IBAction func nine(_ sender: Any) {
        print("9")
        tryingAppendValueToFocusedNumber(userInsertNumber: "9")
        switchClearButtonTitleToC()
        numberButtonPressd_switchStates()

    }
    @IBAction func eight(_ sender: Any) {
        print("8")
        tryingAppendValueToFocusedNumber(userInsertNumber: "8")
        switchClearButtonTitleToC()
        numberButtonPressd_switchStates()
    }
    @IBAction func seven(_ sender: Any) {
        print("7")
        tryingAppendValueToFocusedNumber(userInsertNumber: "7")
        switchClearButtonTitleToC()
        numberButtonPressd_switchStates()
    }
    @IBAction func six(_ sender: Any) {
        print("6")
        tryingAppendValueToFocusedNumber(userInsertNumber: "6")
        switchClearButtonTitleToC()
        numberButtonPressd_switchStates()
    }
    @IBAction func five(_ sender: Any) {
        print("5")
        tryingAppendValueToFocusedNumber(userInsertNumber: "5")
        switchClearButtonTitleToC()
        numberButtonPressd_switchStates()
    }
    @IBAction func four(_ sender: Any) {
        print("4")
        tryingAppendValueToFocusedNumber(userInsertNumber: "4")
        switchClearButtonTitleToC()
        numberButtonPressd_switchStates()
    }
    @IBAction func three(_ sender: Any) {
        print("3")
        tryingAppendValueToFocusedNumber(userInsertNumber: "3")
        switchClearButtonTitleToC()
        numberButtonPressd_switchStates()
    }
    @IBAction func two(_ sender: Any) {
        print("2")
        tryingAppendValueToFocusedNumber(userInsertNumber: "2")
        switchClearButtonTitleToC()
        numberButtonPressd_switchStates()
    }
    @IBAction func one(_ sender: Any) {
        print("1")
        tryingAppendValueToFocusedNumber(userInsertNumber: "1")
        switchClearButtonTitleToC()
        numberButtonPressd_switchStates()
    }
    @IBAction func zero(_ sender: Any) {
        print("0")
        tryingAppendValueToFocusedNumber(userInsertNumber: "0")
        switchClearButtonTitleToC()
        numberButtonPressd_switchStates()
    }
    //禁用输入，当容器中已经存在一个点之后，就不允许再次输入点，并会发出咚咚咚的提示音
    @IBAction func point(_ sender: Any) {
        print(".")
        //playAlertSound()
        print(FocusNumber())
        //检测字符串是否包含小数点，已经包含则不允许再次输入
        if containsCharacter(".", inString: FocusNumber()) {
            AudioServicesPlaySystemSound(alertSound)
            print("already contains the point")
        }else{
            tryingAppendValueToFocusedNumber(userInsertNumber: ".")
        }
    }
    // %
    @IBAction func percent(_ sender: Any) {
        print("%")
        if FocusNumber() == "错误" {
            
        }else{
            setShouldClearScreenToTrue()
            focusNumberDivideBy100()
            refreshDisplay()
        }
        
    }
    // +/-
    @IBAction func positiveNegativeSwitch(_ sender: Any) {
        print("+/-")
        if startsWithMinus(FocusNumber()) {
           removeFocusNumberLeadingMinus()
        }else if containsOnlyZero(FocusNumber()){
            
        }else if FocusNumber() == "错误" {
            
        }else{
            addPrefixToFocusNumber("-")
        }
    }
    // AC/C
    @IBAction func Clear(_ sender: Any) {
        print("All Clear/Clear");
        if clearButton.title == "C"{
            setFocusNumberToZero()
            setShouldClearScreenToTrue()
            switchClearButtonTitleToAC()
        }else if clearButton.title == "AC"{
            backup_number_1 = "empty"
            backup_theOperator = "empty"
            number_1 = "0"
            theOperator = "+"
            number_2 = "0"
        }
    }

    
    // MARK: - 按下功能符
    
    //+ - x ÷
    @IBAction func divide(_ sender: Any) {
        print("÷")
        operatorsButtonPressd_switchStates(theOperatorPressed: "÷")
    }
    @IBAction func times(_ sender: Any) {
        print("x")
        operatorsButtonPressd_switchStates(theOperatorPressed: "x")
    }
    @IBAction func minus(_ sender: Any) {
        print("-")
        operatorsButtonPressd_switchStates(theOperatorPressed: "-")
    }
    @IBAction func plus(_ sender: Any) {
        print("+")
        operatorsButtonPressd_switchStates(theOperatorPressed: "+")
    }
    
    // =
    @IBAction func equal(_ sender: Any) {
        print("=")
        setShouldClearScreenToTrue()
        equalButtonPressd_switchStates()
        
    }

    
    
    func playAlertSound() {
            AudioServicesPlaySystemSound(alertSound)
    }
    //（C、%、÷、x、-、+、=）
    
    // MARK: - 正常运算组数据复制到备用数据组
    func copyNomalGroupDataToBackupGroup() {
        backupGroupIsOpen = true
        backup_number_1 = number_1
        backup_theOperator = theOperator
        number_1 = number_2
    }
    
    // MARK: - 计算结果
    func generateResult(){
        generateNomalGroupResult()
        if backupGroupIsOpen {
            generateBackUpGroupResult()
            closeBackupGroup()
        }
    }
    func generateNomalGroupResult(){
        let decimal1 = Decimal(string: number_1) ?? 0
        let decimal2 = Decimal(string: number_2) ?? 0

        if number_1 == "错误" || number_2 == "错误"{
            setNumber_1To("错误")
        }else if theOperator == "+" {
            let result = decimal1 + decimal2
            print("Sum: \(result)")
            setNumber_1To("\(result)")
            
        } else if theOperator == "-" {
            let result = decimal1 - decimal2
            print("Difference: \(result)")
            setNumber_1To("\(result)")
            
        } else if theOperator == "x" {
            let result = decimal1 * decimal2
            print("Product: \(result)")
            setNumber_1To("\(result)")
            
        } else if theOperator == "÷" {
            // Check for division by zero
            if decimal2 != 0 {
                let result = decimal1 / decimal2
                print("Quotient: \(result)")
                setNumber_1To("\(result)")
            } else {
                setNumber_1To("错误")
                print("Error: Division by zero")
            }
            
            
        }
    }
    func generateBackUpGroupResult(){
        let decimal1 = Decimal(string: backup_number_1) ?? 0
        let decimal2 = Decimal(string: number_1) ?? 0
        
        if number_1 == "错误" || number_2 == "错误"{
            setNumber_1To("错误")
        }else if backup_theOperator == "+" {
            let result = decimal1 + decimal2
            print("Sum: \(result)")
            setNumber_1To("\(result)")
            
        } else if backup_theOperator == "-" {
            let result = decimal1 - decimal2
            print("Difference: \(result)")
            setNumber_1To("\(result)")
            
        } else if backup_theOperator == "x" {
            let result = decimal1 * decimal2
            print("Product: \(result)")
            setNumber_1To("\(result)")
            
        } else if backup_theOperator == "÷" {
            // Check for division by zero
            if decimal2 != 0 {
                let result = decimal1 / decimal2
                print("Quotient: \(result)")
                setNumber_1To("\(result)")
            } else {
                setNumber_1To("错误")
                print("Error: Division by zero")
            }
        }
    }
    
    
    // MARK: - 更新运算符容器
    func updateTheOperator(_ theNewOperator:String){
        theOperator = theNewOperator
    }
    
    // MARK: - 自动补充运算数
    func overwritingNumber_2WithNumber_1(){
        overwriteDestinationNumber(withSourceNumber: number_1, destinationNumber: &number_2)
        
    }
    func overwritingNumber_1WithNumber_2(){
        overwriteDestinationNumber(withSourceNumber: number_1, destinationNumber: &number_2)
    }
    func overwriteDestinationNumber(withSourceNumber sourceNumber: String, destinationNumber: inout String) {
        destinationNumber = sourceNumber
    }
    
    
    // MARK: - 获取显示在屏幕上的数据
    func FocusNumber() -> String {
        if focusNumber == "number_1" {
            return number_1
        } else if focusNumber == "number_2" {
            return number_2
        } else {
            // 如果没有匹配到特定的 focusNumber，可以返回一个默认的引用或者抛出错误，视情况而定
            fatalError("Invalid focusNumber")
        }
    }
    
    // MARK: - 用于编辑focusNumber的函数
    func addPrefixToFocusNumber(_ prefix: String) {
        // 先找到要进行操作的容器
        if focusNumber == "number_1" {
            number_1 = addPrefix(prefix, to: number_1)
        } else if focusNumber == "number_2" {
            number_2 = addPrefix(prefix, to: number_2)
        } else {
            fatalError("Invalid focusNumber")
        }
        refreshDisplay()
    }
    func addPrefix(_ prefix: String, to target: String) -> String{
        return prefix + target
    }
    //-------
    func removeFocusNumberLeadingMinus(){
        if focusNumber == "number_1" {
            number_1 = removeLeadingMinus(number_1)
        } else if focusNumber == "number_2" {
            number_2 = removeLeadingMinus(number_2)
        }
        refreshDisplay()
    }
    func removeLeadingMinus(_ str: String) -> String {
        if str.hasPrefix("-") {
            return String(str.dropFirst())
        } else {
            return str
        }
    }
    //-------
    func focusNumberDivideBy100(){
        if focusNumber == "number_1" {
            number_1 = "\(divideBy100(Decimal(string: number_1) ?? 0))"
        } else if focusNumber == "number_2" {
            number_2 = "\(divideBy100(Decimal(string: number_2) ?? 0))"
        }
    }
    func divideBy100(_ number: Decimal) -> Decimal {
        let divisor = Decimal(100)
        return number / divisor
    }
    //------
    func setFocusNumberToZero(){
        if focusNumber == "number_1" {
            number_1 = "0"
        }else if focusNumber == "number_2"{
            number_2 = "0"
        }
        refreshDisplay()
    }
    //------
    func setNumber_1To(_ value:String){
        number_1 = value
        refreshDisplay()
    }
    //------
    func setFocusNumberTo(_ value:String){
        if focusNumber == "number_1" {
            number_1 = value
        } else if focusNumber == "number_2" {
            number_2 = value
        }
        refreshDisplay()
    }
    //------
    func tryingAppendValueToFocusedNumber(userInsertNumber: String) {
        if focusNumber == "number_1" {
            print("focusNumber is number_1")
            tryingAppendValueToString(attachment: userInsertNumber, str: &number_1)
        } else if focusNumber == "number_2" {
            print("focusNumber is number_2")
            tryingAppendValueToString(attachment: userInsertNumber, str: &number_2)
        }
        refreshDisplay()
    }
    func tryingAppendValueToString(attachment: String, str: inout String) {
        if shouldClearScreen {
            if attachment == "."{
                str = "0" + attachment
            }else{
                str = attachment
            }
            setShouldClearScreenTofalse()
        } else {
            if containsOnlyZero(str) && attachment == "." {
                str = str + attachment
            } else if containsOnlyZero(str) {
                str = attachment
            } else {
                str = str + attachment
            }
        }
    }
      
    
    // MARK: - 用于状态检测的函数
    func startsWithMinus(_ str: String) -> Bool {
        return str.hasPrefix("-")
    }
    func containsCharacter(_ character: Character, inString str: String) -> Bool {
        return str.contains(character)
    }
    func startsWithZero(_ str: String) -> Bool {
        return str.hasPrefix("0")
    }
    func containsOnlyZero(_ str: String) -> Bool {
        return str.allSatisfy { $0 == "0" }
    }
    

    // MARK: - 用于切换状态的函数
    
    // 按下数字键后进行一个状态的切换 1 2 3 4 5 6 7 8 9 0 .
    func numberButtonPressd_switchStates(){
        if focusNumber == "number_1" && number_2_inputFromUser == false {
            //状态不变
        }else if focusNumber == "number_2" && number_2_inputFromUser == false {
            setNumber_2_inputFromUserToTrue();
        }else if focusNumber == "number_2" && number_2_inputFromUser == true {
            //状态不变
        }else if backupGroupIsOpen == true && focusNumber == "number_2" && number_2_inputFromUser == false{
            setNumber_2_inputFromUserToTrue();
        }else if backupGroupIsOpen == true && focusNumber == "number_2" && number_2_inputFromUser == true{
            //状态不变
        }
        refreshDisplay()
    }
    
    // 按下运算符后进行一个状态的切换 + - x ÷
    func operatorsButtonPressd_switchStates(theOperatorPressed:String){
        setShouldClearScreenToTrue()
        if focusNumber == "number_1" && number_2_inputFromUser == false {
            updateTheOperator(theOperatorPressed)
            overwritingNumber_2WithNumber_1()
            switchfoucsNumber()
        }else if focusNumber == "number_2" && number_2_inputFromUser == false {
            updateTheOperator(theOperatorPressed)
            //状态不变
        }else if focusNumber == "number_2" && number_2_inputFromUser == true {
            if (theOperator == "+" || theOperator == "-") && (theOperatorPressed == "x" || theOperatorPressed == "÷") {
                copyNomalGroupDataToBackupGroup()
                updateTheOperator(theOperatorPressed)
                overwritingNumber_2WithNumber_1()
                setNumber_2_inputFromUserToFalse()
            }else{
                generateResult()
                setNumber_2_inputFromUserToFalse()
                updateTheOperator(theOperatorPressed)
                overwritingNumber_2WithNumber_1()
            }
        }else if backupGroupIsOpen == true && focusNumber == "number_2" && number_2_inputFromUser == false{
            if (theOperatorPressed == "+" || theOperatorPressed == "-") {
                generateBackUpGroupResult()
                updateTheOperator(theOperatorPressed)
                overwritingNumber_2WithNumber_1()
                closeBackupGroup()
            }else{
                updateTheOperator(theOperatorPressed)
                //状态不变
            }
        }else if backupGroupIsOpen == true && focusNumber == "number_2" && number_2_inputFromUser == true{
            generateResult()
            updateTheOperator(theOperatorPressed)
            overwritingNumber_2WithNumber_1()
            setNumber_2_inputFromUserToFalse()
            closeBackupGroup()
        }
        refreshDisplay()
    }
    
    // 按下等于后进行一个状态的切换 =
    func equalButtonPressd_switchStates(){
        if focusNumber == "number_1" && number_2_inputFromUser == false {
            generateResult()
        }else if focusNumber == "number_2" && number_2_inputFromUser == false {
            generateResult()
            switchfoucsNumber()
        }else if focusNumber == "number_2" && number_2_inputFromUser == true {
            generateResult()
            switchfoucsNumber()
            setNumber_2_inputFromUserToFalse()
        }else if backupGroupIsOpen == true && focusNumber == "number_2" && number_2_inputFromUser == false{
            generateResult()
            switchfoucsNumber()
            setNumber_2_inputFromUserToFalse()
            closeBackupGroup()
        }else if backupGroupIsOpen == true && focusNumber == "number_2" && number_2_inputFromUser == true{
            generateResult()
            switchfoucsNumber()
            setNumber_2_inputFromUserToFalse()
            closeBackupGroup()
        }
        refreshDisplay()
    }
    
    
    func setNumber_2_inputFromUserToFalse(){
        number_2_inputFromUser = false
    }
    func setNumber_2_inputFromUserToTrue(){
        number_2_inputFromUser = true
    }
    func switchClearButtonTitleState(){
        if clearButton.title == "C"{
            clearButton.title = "AC"
        }else if clearButton.title == "AC"{
            clearButton.title = "C"
        }
    }
    func closeBackupGroup() {
        backup_number_1 = "empty"
        backup_theOperator = "empty"
        backupGroupIsOpen = false
    }
    func switchClearButtonTitleToC(){
        clearButton.title = "C"
    }
    func switchClearButtonTitleToAC(){
        clearButton.title = "AC"
    }
    func setShouldClearScreenToTrue(){
        shouldClearScreen = true
    }
    func setShouldClearScreenTofalse(){
        shouldClearScreen = false
    }
    func switchNumber_2_inputFromUserState(){
        if number_2_inputFromUser == false {
            number_2_inputFromUser = true
        }else if number_2_inputFromUser == true{
            number_2_inputFromUser = false
        }
    }
    func switchfoucsNumber(){
        if focusNumber == "number_1" {
            focusNumber = "number_2"
        }else if focusNumber == "number_2"{
            focusNumber = "number_1"
        }
        refreshDisplay()
    }
    func refreshDisplay(){
        if focusNumber == "number_1" {
            screen.stringValue = "\(number_1)"
        }else if focusNumber == "number_2"{
            screen.stringValue = "\(number_2)"
        }
    }
}



