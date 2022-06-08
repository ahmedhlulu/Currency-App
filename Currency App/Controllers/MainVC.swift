//
//  ViewController.swift
//  Currency App
//
//  Created by Ahmed on 07/05/2022.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
            
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = arrCurrencyNameAR[0]
        tableView.dataSource = self
        tableView.delegate = self
        getCurrency()
        
        NotificationCenter.default.addObserver(self, selector: #selector(CurrencyNameChanged), name: NSNotification.Name("CurrencyChanged"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name("DataIsHere"), object: nil)
    }
    
    @objc func reloadData(notification: Notification){
            tableView.reloadData()
    }
    
    @objc func CurrencyNameChanged(notification: Notification){
        if let currencyAR = notification.userInfo?["CurrencyNameAR"] as? String {
            title = currencyAR
            getCurrency()
            tableView.reloadData()
        }
    }
        
    @IBAction func calcButton(_ sender: Any) {
        tableView.reloadData()
    }
}

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCurrencyNameAR.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        let strToNum = Double(numberTextField.text!) ?? 1
        
        cell.textLabel?.textAlignment = .right
        cell.textLabel?.text = arrCurrencyNameAR[indexPath.row] + ": \(Float(strToNum * myRates[indexPath.row]))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        myCurrency = arrCurrencyName[indexPath.row]
        title = arrCurrencyNameAR[indexPath.row]
        getCurrency()
        tableView.reloadData()
    }
}
