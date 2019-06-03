# radioButtonGroup
radio button framework

```swift
import radioButtonGroup
```

## 버튼 1개
  ### 코드에서 생성
  ```swift
    var btn1: RadioButtonView!
    
    btn1 = RadioButtonView(frame: CGRect(x: 30, y: 100, width: 200, height: 100))
    view.addSubview(btn1)
    btn1.setLabel(text: "[1번] 코드에서 생성한 버튼", labelId: "testBtn1")
    btn1.setImage(normal: UIImage(named: "btn_radio_off")!, selected: UIImage(named: "btn_radio_on")!)
    btn1.sizeToFit()
  ```
  ### 인터페이스 빌더에서 생성
  ```swift
    @IBOutlet weak var btn2: RadioButtonView!
    
    btn2.setLabel(text: "[2번] 인터페이스 빌더에서 생성한 버튼 길어졌을때 쩜쩜쩜 ", labelId: "testBtn2")
    btn2.setImage(normal: UIImage(named: "btn_radio_off")!, selected: UIImage(named: "btn_radio_on")!)
  ```

## 버튼 그룹핑
  ### 데이터 모델 사용
  ```swift
      var itemModel1: [RadioButtonItemModel] = [RadioButtonItemModel.init(id: "BASE1", name: "삼성 라이온즈"),
                                         RadioButtonItemModel.init(id: "BASE2", name: "엘지 트윈스"),
                                         RadioButtonItemModel.init(id: "BASE3", name: "두산 베어스"),
                                         RadioButtonItemModel.init(id: "BASE4", name: "케이티 위즈"),
                                         RadioButtonItemModel.init(id: "BASE5", name: "기아 타이거즈")]
      var itemModel2: [RadioButtonItemModel] = [RadioButtonItemModel.init(id: "TAE", name: "이태민"),
                                     RadioButtonItemModel.init(id: "SHINE1", name: "최민호"),
                                     RadioButtonItemModel.init(id: "SHINE2", name: "김기범"),
                                     RadioButtonItemModel.init(id: "SHINE3", name: "김종현"),
                                     RadioButtonItemModel.init(id: "SHINE4", name: "이진기")]
      var itemModel3: [RadioButtonItemModel] = [RadioButtonItemModel.init(id: "THR1", name: "서울"),
                                     RadioButtonItemModel.init(id: "THR2", name: "춘천"),
                                     RadioButtonItemModel.init(id: "THR3", name: "대전"),
                                     RadioButtonItemModel.init(id: "THR4", name: "대구"),
                                     RadioButtonItemModel.init(id: "THR5", name: "부산")]
  ```
  ### 속성
  ```swift
        var groupView: RadioButtonGroupView
        ...
        groupView.backgroundColor = UIColor.white
        groupView.buttonImageNORMAL = UIImage(named: "btn_radio_off")!
        groupView.buttonImageSELECTED = UIImage(named: "btn_radio_on")!
        
        groupView.itemInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        groupView.font = UIFont.systemFont(ofSize: 13)
        groupView.foreGroundColor = UIColor.black
                
        groupView.useSectionHeaderTitle = true
        groupView.headerInset = UIEdgeInsets(top: 18, left: 11, bottom: 0, right: 0)
        groupView.headerFont = UIFont.systemFont(ofSize: 16)
        groupView.headerForeGroundColor = UIColor.darkGray

        groupView.itemPerRow = 2
        groupView.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        groupView.sectionBorder = [.bottom]
        groupView.sectionBorderWidth = ApplicationConstants.onePointBorder
        groupView.sectionBorderColor = UIColor(hex: 0xe5e5e5, alpha: 1)
        
        // 기본적으로 선택되어 노출될 항목 설정
        groupView.defaultId = "RadioButtonItemModel.id value"
        
        groupView.delegate = self
        
        groupView.bindModel(data: [RadioButtonGroupItemModel(name: "야구", items: itemModel1), RadioButtonGroupItemModel(name: "샤이니", items: itemModel2),
            RadioButtonGroupItemModel(name: "우리나라", items: itemModel3)])
            
        //레이아웃 정렬해줌
        groupView.sizeToFit()
  ```
  ### 선택한 라디오 버튼의 아이디를 가져올때
  ```swift
    getSelectedItem() -> String?
  ```
  ### 라디오 버튼이 선택되었을때 발생하는 이벤트
  ```swift
    //RadioButtonDelegate.radioButtonSelected(itemId:)
    extension GroupViewController: RadioButtonDelegate {
        func radioButtonSelected(itemId: String) {
            debugPrint("선택된 라디오 버튼의 아이디는 \(itemId) 입니당")
        }
    }
  ```
