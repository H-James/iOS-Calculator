//
//  ViewController.m
//  Calculator
//
//  Created by James Liu on 2023/9/26.
//

#import "ViewController.h"


NSNumber * A;
NSNumber * sign;
NSNumber * B;
NSNumber * result;
NSNumber * algorithmCache_sign;
NSNumber * algorithmCache_B;
NSNumber * cunrrentDisplay;

@interface ViewController ()



@end

@implementation ViewController



- (void)setToDisplay:(NSNumber *)theObject{
    
    if ([theObject isEqualToNumber:@1]) {
        _resultLable.text = A.stringValue;
    }
    if ([theObject isEqualToNumber:@3]) {
        _resultLable.text = sign.stringValue;
    }
    if ([theObject isEqualToNumber:@4]) {
        _resultLable.text = result.stringValue;
    }
   
}

- (void)viewDidLoad {
    [super viewDidLoad];

    A = nil;  //1
    sign = nil;  //2
    B = nil;  //3
    result = nil;  //4
    algorithmCache_sign = nil;  //5
    algorithmCache_B = nil;  //6
    cunrrentDisplay = nil;  //7

    A = @10;

    cunrrentDisplay = @1;

    [self setToDisplay:cunrrentDisplay];
}

- (IBAction)numberZeroButtonRelesed:(id)sender {
    NSLog(@"0");
}

- (IBAction)numberOneButtonRelesed:(id)sender {
    NSLog(@"1");
}

- (IBAction)numberTwoButtonRelesed:(id)sender {
    NSLog(@"2");
}

- (IBAction)numberThreeButtonRelesed:(id)sender {
    NSLog(@"3");
}

- (IBAction)numberFourButtonRelesed:(id)sender {
    NSLog(@"4");
}

- (IBAction)numberFiveButtonRelesed:(id)sender {
    NSLog(@"5");
}

- (IBAction)numberSixButtonRelesed:(id)sender {
    NSLog(@"6");
}

- (IBAction)numberSevenButtonRelesed:(id)sender {
    NSLog(@"7");
}

- (IBAction)numberEightButtonRelesed:(id)sender {
    NSLog(@"8");
}

- (IBAction)numberNineButtonRelesed:(id)sender {
    NSLog(@"9");
}

- (IBAction)dotButtonRelesed:(id)sender {
    NSLog(@".");
}

- (IBAction)equalButtonRelesed:(id)sender {
    NSLog(@"=");
    
    
    
}




- (IBAction)plusButtonRelesed:(id)sender {
    NSLog(@"+");
    
}

- (IBAction)minusButtonRelesed:(id)sender {
    NSLog(@"-");
}

- (IBAction)multiplyButtonRelesed:(id)sender {
    NSLog(@"*");
}

- (IBAction)divideButtonRelesed:(id)sender {
    NSLog(@"÷");
    
}




- (IBAction)percentageButtonRelesed:(id)sender {
    NSLog(@"%%");
}

- (IBAction)invertNumberButtonRelesed:(id)sender {
    NSLog(@"+/-");
}

- (IBAction)allClearButtonRelesed:(id)sender {
    NSLog(@"AC");
    
}

    

@end

