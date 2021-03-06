//
//  MachineInfoTableViewCell.swift
//  LaundryView
//
//  Created by Sam Singh on 8/12/18.
//  Copyright © 2018 Mango Hut. All rights reserved.
//

import UIKit

class MachineInfoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var InfoContainer: UIView!
    @IBOutlet weak var CellContainer: UIView!
    @IBOutlet weak var MachineStatus: UILabel!
    @IBOutlet weak var MachineNumContainer: UIView!
    @IBOutlet weak var MachineNum: UILabel!
    @IBOutlet weak var MachineStatusIcon: UIView!
    @IBOutlet weak var MachineStatusIconImage: UIImageView!
    @IBOutlet weak var ProgressBar: CircularProgressBar!
    
    var cellIndex: Int = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        CellContainer.layer.cornerRadius = 10
        CellContainer.layer.shadowColor = UIColor.black.cgColor
        CellContainer.layer.shadowOpacity = 0.2
        CellContainer.layer.shadowRadius = 2
        CellContainer.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        InfoContainer.layer.cornerRadius = InfoContainer.frame.size.height / 2
        InfoContainer.layer.shadowColor = UIColor.black.cgColor
        InfoContainer.layer.shadowOpacity = 0.2
        InfoContainer.layer.shadowRadius = 4
        InfoContainer.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        MachineNumContainer.layer.cornerRadius = MachineNumContainer.frame.size.height / 2
        MachineNumContainer.layer.shadowColor = UIColor.black.cgColor
        MachineNumContainer.layer.shadowOpacity = 0.2
        MachineNumContainer.layer.shadowRadius = 2
        MachineNumContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        MachineStatusIcon.layer.cornerRadius = MachineStatusIcon.frame.size.height / 2
        MachineStatusIcon.layer.shadowColor = UIColor.black.cgColor
        MachineStatusIcon.layer.shadowOpacity = 0.15
        MachineStatusIcon.layer.shadowRadius = 3
        MachineStatusIcon.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        ProgressBar.transform = ProgressBar.transform.rotated(by: CGFloat.pi / -2)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.showModal))
        self.contentView.addGestureRecognizer(gesture)
        
    }
    
    
    public func updateCellData(machine: Machine){
        
        self.MachineNum.text = "\(machine.machineID)"
        
        self.MachineStatus.text = "\(machine.currentStatus.rawValue)"
        
        cellIndex = machine.machineID - 1
        
        var color : Colors
        var progress : Float
        var statusIcon : UIImage
        
        switch(machine.currentStatus){
            
            case .Available:
                color = Colors.AVAILABLE
                progress = Float(1.0)
                statusIcon = UIImage(named: "done")!
            
            case .In_Progress:
                color = Colors.IN_USE
                progress = Float(machine.progress)
                statusIcon = machine.machineType == .Washer ? UIImage(named: "droplet")! : UIImage(named: "air")!
            
            case .Done_Door_Closed:
                color = Colors.IDLE
                progress = Float(1.0)
                statusIcon = UIImage(named: "waiting")!
            
            
            default:
                color = Colors.UNKNOWN
                progress = Float(1.0)
                statusIcon = UIImage(named: "cancel")!
            
            
        }
        
        self.MachineStatusIcon.backgroundColor = Utilities.hexStringToUIColor(hex: color.rawValue)
        self.ProgressBar.progress = progress
        
        MachineStatusIconImage.image = statusIcon
        MachineStatusIconImage.image = MachineStatusIconImage.image!.withRenderingMode(.alwaysTemplate)
        MachineStatusIconImage.tintColor = Utilities.hexStringToUIColor(hex: color.rawValue)
        
        self.ProgressBar.progressLayer.strokeColor = Utilities.hexStringToUIColor(hex: color.rawValue).cgColor
        
    }
    
    @objc private func showModal(){
        let info = ["index":cellIndex]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: BASE_NOTIFICATION_KEY + SHOW_MACHINE_MODAL), object: nil, userInfo: info)
    }
    


}
