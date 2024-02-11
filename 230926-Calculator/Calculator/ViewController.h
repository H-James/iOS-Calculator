//
//  ViewController.h
//  Calculator
//
//  Created by James Liu on 2023/9/26.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    
}
    
@property (weak, nonatomic) IBOutlet UILabel *resultLable;


-(void)setToDisplay:(NSNumber *)theObject;

@end

