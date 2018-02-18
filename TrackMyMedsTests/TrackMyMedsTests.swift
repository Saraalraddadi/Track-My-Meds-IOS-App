//
//  TrackMyMedsTests.swift
//  TrackMyMedsTests
//


import XCTest
@testable import TrackMyMeds
@testable import Pods_TrackMyMeds

class TrackMyMedsTests: XCTestCase {
    
    var tabVC = UITabBarController()
    var navVC = UINavigationController()
    var alarmVC: AlarmViewController!
    var medicineVC: MedicineViewController!
    var alarmCountOnthatDay: Int!
    
    
    override func setUp() {
        super.setUp()
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        tabVC =  storyBoard.instantiateInitialViewController() as! UITabBarController
        navVC = tabVC.viewControllers![2] as! UINavigationController
        medicineVC = navVC.visibleViewController as! MedicineViewController
       

    }
    
    func testAddMedicine(){
        
        
        let addMedicineVC = AddMedicineViewController()
        medicineVC.show(addMedicineVC, sender: medicineVC)
        
        addMedicineVC.appearImage = "Med5"
        addMedicineVC.colorImage = "Yellow"
        let image = #imageLiteral(resourceName: "Green")
        let imageData = image.jpeg(.lowest) as NSData!
        addMedicineVC.imageData = imageData!
        addMedicineVC.mediText = "medicine name test"
        addMedicineVC.dosageText = "dosage test"
        addMedicineVC.descText = "description test"
        addMedicineVC.brandText = "brand name test"
       
        addMedicineVC.addTapped()
        medicineVC.fetchAllMed()
        
        let medi = medicineVC.allMed.last
        
        XCTAssert(medi?.appearImg == "Med5", "appear image not saved successfully")
        XCTAssert(medi?.colorImg == "Yellow", "color image not saved successfully")
        XCTAssert(medi?.medDosage == "dosage test", "dosage info not saved successfully")
        XCTAssert(medi?.medName == "medicine name test", "medicine name not saved successfully")
        XCTAssert(medi?.brandName == "brand name test", "brand name not saved successfully")
        XCTAssert(medi?.mediDescription == "description test", "description info not saved successfully")
        XCTAssert(medi?.medImgData == imageData, "image data not saved successfully")
        
    }
    
    
    func testIsThatMedicineTableViewReload() {
        
        medicineVC.fetchAllMed()
       
        let totalMedicine = medicineVC.allMed.count
      
        self.testAddMedicine()
       
        let afterFetchCount = medicineVC.allMed.count
        XCTAssert(afterFetchCount == totalMedicine + 1, "array not reload data and table view not reload data")
    }
    
    func testAddAlarmAndReloadAlarmTV(){
        navVC = tabVC.viewControllers![1] as! UINavigationController
        alarmVC = navVC.visibleViewController as! AlarmViewController
        let addAlarmVC = AddAlarmViewController()
        if addAlarmVC.alarm == nil {
            addAlarmVC.fetchAllMed()
        }
        alarmVC.fetchAllAlarm()
        let alarmCount = alarmVC.allAlarm.count
        print("this is the alarm count is  ::::: \(alarmCount)")
        
        addAlarmVC.alarm = Alarm.mr_createEntity()
        
        addAlarmVC.thisMed = addAlarmVC.allMed[1]
        addAlarmVC.medNameis = addAlarmVC.thisMed.medName
        addAlarmVC.AlarmTime = "2017-06-13 12:12 a"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let date = dateFormatter.date(from:  "2017/06/13")
        addAlarmVC.alarm?.alarmDT = date as NSDate?
        addAlarmVC.alarm?.alarmDate = "2017/06/13"
        
        addAlarmVC.addTapped()
        alarmVC.fetchAllAlarm()
        
        let afterFetchAlarmCount = alarmVC.allAlarm.count
         print("this is the all fetch alarm count is  ::::: \(afterFetchAlarmCount)")
       
        let alarm = alarmVC.allAlarm.last
        
        XCTAssert(alarm?.alarmTLabel == addAlarmVC.AlarmTime, "alarm time not saved successfully")
        XCTAssert(alarm?.medicineName == addAlarmVC.medNameis, "alarm medicine name is not saved successfully")
        XCTAssert(alarm?.medicine == addAlarmVC.thisMed, "medicine info not saved successfully")
        XCTAssert(afterFetchAlarmCount == alarmCount + 1, "alarm array not reload so alarm table not reload")
       
    }
    
    func testDetailOfMedicineCorrect(){
        let detailMedVC = MedicineDetailsViewController()
        
        var selectedRowNum = 2
        medicineVC.fetchAllMed()
        medicineVC.allImagesInArray()
        if medicineVC.allMed.count >= selectedRowNum {
            detailMedVC.medi = medicineVC.allMed[selectedRowNum - 1]
            if medicineVC.allImages.count >= selectedRowNum {
                detailMedVC.selectedMedImg = medicineVC.allImages[selectedRowNum - 1]
            }
        }
        
        let tempMed = medicineVC.allMed[selectedRowNum - 1]
        
        XCTAssert(detailMedVC.medi?.appearImg == tempMed.appearImg, "appear image not showing successfully")
        XCTAssert(detailMedVC.medi?.colorImg == tempMed.colorImg, "color image not showing successfully")
        XCTAssert(detailMedVC.medi?.medDosage == tempMed.medDosage, "dosage info not showing successfully")
        XCTAssert(detailMedVC.medi?.medName == tempMed.medName, "medicine name not showing successfully")
        XCTAssert(detailMedVC.medi?.brandName == tempMed.brandName, "brand name not showing successfully")
        XCTAssert(detailMedVC.medi?.mediDescription == tempMed.mediDescription, "description info not showing successfully")
        
    }
    
    func testShowAlarmOnDateCorrect(){
        let homeVC = HomeViewController()
        homeVC.fetchAllMed()
        homeVC.fetchAllMedLog()
        
        let selectedMedNum = 1
        let tempMed = homeVC.allMed[selectedMedNum - 1]
        
        homeVC.selectedDate = "2017/06/13"
        homeVC.selectedMedi = tempMed.medName!
        
        homeVC.allAlarmOnThatDate.removeAll()
        homeVC.fetchAllAlarm()
        
        if homeVC.allAlarm.count > 0 {
            for i in 0...((homeVC.allAlarm.count) - 1) {
                let tempAlarm = homeVC.allAlarm[i]
                let compareDate:String = tempAlarm.alarmDate!
                if homeVC.selectedDate == compareDate {
                    homeVC.allAlarmOnThatDate.append(homeVC.allAlarm[i])
                    self.alarmCountOnthatDay = homeVC.allAlarmOnThatDate.count
                }
            }
        }
        
        XCTAssert(homeVC.allAlarmOnThatDate.count == alarmCountOnthatDay, "alarm not proper showing on that selected date")
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
   
    
}
