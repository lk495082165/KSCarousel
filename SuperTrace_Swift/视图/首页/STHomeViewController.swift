//
//  STHomeViewController.swift
//  SuperTrace_Swift
//
//  Created by 程强 on 16/11/9.
//  Copyright © 2016年 程强. All rights reserved.
//

import UIKit

class STHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let imgAry  = NSArray.init(objects: "banner1.png","banner2.png","banner3.png")
        let carousel = KSCarousel.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 184))
        self.view.addSubview(carousel)
        carousel.setDataAry(ary: imgAry)
        
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
