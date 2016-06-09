//
//  QuestionViewController.swift
//  WordList
//
//  Created by 尾高文香 on 2016/06/09.
//  Copyright © 2016年 com.odakaayaka. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    
    var isAnswered: Bool = false //回答したか次の問題にいくかの判定
    var wordArray: [AnyObject] = [] //ユーザーデフォルトからとる配列
    var shuffledWordArray: [AnyObject] = []
    var nowNumber: Int = 0 //現在の回答数
    
    let saveData = NSUserDefaults.standardUserDefaults()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        answerLabel.text = ""
        // Do any additional setup after loading the view.
    }
    //viewが現れた時に呼ばれる
    
    override func viewWillAppear(animated: Bool){
        wordArray = saveData.arrayForKey("WORD")!
        //問題をシャッフルする
        shuffle()
        questionLabel.text = shuffledWordArray[nowNumber]["english"] as? String
    }
    
    func shuffle(){
        while wordArray.count > 0{
            let index = Int(rand()) % wordArray.count
            shuffledWordArray.append(wordArray[index]) //配列をランダムにシャッフル
            wordArray.removeAtIndex(index)
        }
    }
    
    @IBAction func nextButtonPushed(){
        //回答したか
        if isAnswered{
            //次の問題へ
            nowNumber++
            answerLabel.text = ""
            
            //次の問題を表示するか
            if nowNumber < shuffledWordArray.count{
                //次の問題を表示
                questionLabel.text = shuffledWordArray[nowNumber]["english"] as? String
                //isAnsweredをfalseにする
                isAnswered = false
                //ボタンのタイトルを変更する
                nextButton.setTitle("答えを表示", forState: UIControlState.Normal)
            }else{
                //これ以上表示する問題はないので,Finishビューに画面遷移
                self.performSegueWithIdentifier("toFinishView", sender: nil)
            }
        }else{
            //答えを表示する
            answerLabel.text = shuffledWordArray[nowNumber]["japanese"] as? String
            //isAnswerdをtrueにする
            isAnswered = true
            //ボタンのタイトルを変更する
            nextButton.setTitle("次へ", forState: UIControlState.Normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
