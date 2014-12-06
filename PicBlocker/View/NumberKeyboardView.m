//
//  NumberKeyboardView.m
//  PicBlocker
//
//  Created by NhanB on 12/6/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import "NumberKeyboardView.h"
#define kBackspaceButtonTag             20

@implementation NumberKeyboardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {

}

#pragma mark - Common Methods

- (void)initKeyboard {
    CGSize size = self.frame.size;
    
    int widthOfButton = size.width/3;
    int heightOfButton = 45;
    float yStart = size.height - heightOfButton*4;
    int count = 0;
    
    for (int i=0; i<4; i++) {
        for (int j=0; j<3; j++) {
            count++;
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(j*widthOfButton, yStart + i*heightOfButton, widthOfButton, heightOfButton);
            [button addTarget:self action:@selector(numberButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = [UIFont systemFontOfSize:30];
            
            if (i == 3) {
                if (j == 0) {
                    // add non-button
                    [button setTitle:@"" forState:UIControlStateNormal];
                    button.userInteractionEnabled = NO;
                } else if (j == 1) {
                    [button setTitle:@"0" forState:UIControlStateNormal];
                    button.tag = 0;
                } else {
                    // add backspace button
                    [button setImage:[UIImage imageNamed:@"back_space_icon"] forState:UIControlStateNormal];
                    button.tag = kBackspaceButtonTag;
                }
            } else {
                [button setTitle:[NSString stringWithFormat:@"%d", count] forState:UIControlStateNormal];
                button.tag = count;
            }
            
            [self addSubview:button];
            
            button.layer.borderWidth = 1;
            button.layer.borderColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1].CGColor;
        }
    }
}

#pragma mark - Events

- (IBAction)numberButtonClicked:(UIButton *)sender {
}

- (IBAction)backspaceButtonClicked:(UIButton *)sender {
}

@end
