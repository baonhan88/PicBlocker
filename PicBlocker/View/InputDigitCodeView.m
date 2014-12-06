//
//  InputDigitCodeView.m
//  PicBlocker
//
//  Created by NhanB on 12/6/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import "InputDigitCodeView.h"

@interface InputDigitCodeView()

@property (strong, nonatomic) IBOutlet UIView *digitBorder1View;
@property (strong, nonatomic) IBOutlet UIView *digitBorder2View;
@property (strong, nonatomic) IBOutlet UIView *digitBorder3View;
@property (strong, nonatomic) IBOutlet UIView *digitBorder4View;

@property (strong, nonatomic) IBOutlet UIImageView *dotImage1View;
@property (strong, nonatomic) IBOutlet UIImageView *dotImage2View;
@property (strong, nonatomic) IBOutlet UIImageView *dotImage3View;
@property (strong, nonatomic) IBOutlet UIImageView *dotImage4View;

@property (strong, nonatomic) NSString *digitCodeString;

@end

@implementation InputDigitCodeView

- (void)awakeFromNib {
    _digitCodeString = @"";
    
    // init input digit code view
    _digitBorder1View.layer.borderColor = [UIColor colorWithRed:205.0/255.0 green:229.0/255.0 blue:214.0/255.0 alpha:1.0].CGColor;
    _digitBorder1View.layer.borderWidth = 1;
    
    _digitBorder2View.layer.borderColor = [UIColor colorWithRed:205.0/255.0 green:229.0/255.0 blue:214.0/255.0 alpha:1.0].CGColor;
    _digitBorder2View.layer.borderWidth = 1;
    
    _digitBorder3View.layer.borderColor = [UIColor colorWithRed:205.0/255.0 green:229.0/255.0 blue:214.0/255.0 alpha:1.0].CGColor;
    _digitBorder3View.layer.borderWidth = 1;
    
    _digitBorder4View.layer.borderColor = [UIColor colorWithRed:205.0/255.0 green:229.0/255.0 blue:214.0/255.0 alpha:1.0].CGColor;
    _digitBorder4View.layer.borderWidth = 1;
    
    _dotImage1View.hidden = YES;
    _dotImage2View.hidden = YES;
    _dotImage3View.hidden = YES;
    _dotImage4View.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Common Methods

- (void)updateDigitDot {
    if (_digitCodeString.length == 0) {
        _dotImage1View.hidden = YES;
        _dotImage2View.hidden = YES;
        _dotImage3View.hidden = YES;
        _dotImage4View.hidden = YES;
    } else if (_digitCodeString.length == 1) {
        _dotImage1View.hidden = NO;
        _dotImage2View.hidden = YES;
        _dotImage3View.hidden = YES;
        _dotImage4View.hidden = YES;
    } else if (_digitCodeString.length == 2) {
        _dotImage1View.hidden = NO;
        _dotImage2View.hidden = NO;
        _dotImage3View.hidden = YES;
        _dotImage4View.hidden = YES;
    } else if (_digitCodeString.length == 3) {
        _dotImage1View.hidden = NO;
        _dotImage2View.hidden = NO;
        _dotImage3View.hidden = NO;
        _dotImage4View.hidden = YES;
    } else if (_digitCodeString.length >= 4) {
        _dotImage1View.hidden = NO;
        _dotImage2View.hidden = NO;
        _dotImage3View.hidden = NO;
        _dotImage4View.hidden = NO;
    }
}

- (void)checkDigitCode {
    
    [self updateDigitDot];
    
    if (_digitCodeString.length >= 4) {
        if ([_digitCodeString isEqualToString:[Utils getPasscode]]) {
            [self processCloseDigitCodeView];
            
            // input digit done
            if (_delegate && [_delegate respondsToSelector:@selector(processInputDigitDone)]) {
                [_delegate processInputDigitDone];
            }
        } else {
            // re-input digit code
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                                message:@"Digit code not matched, please try again"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
            [alertView show];
            
            _digitCodeString = @"";
            [self updateDigitDot];
        }
    }
}

- (void)processCloseDigitCodeView {
    [self removeFromSuperview];
    
    if (_delegate && [_delegate respondsToSelector:@selector(digitCodeViewClosed)]) {
        [_delegate digitCodeViewClosed];
    }
}

#pragma mark - Events

- (IBAction)numberButtonClicked:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    // process click number button
    _digitCodeString = [NSString stringWithFormat:@"%@%ld", _digitCodeString, button.tag];
    [self checkDigitCode];
}


- (IBAction)backspaceButtonClicked:(id)sender {
    // process backspace
    if ([_digitCodeString length] > 0) {
        _digitCodeString = [_digitCodeString substringToIndex:[_digitCodeString length] - 1];
        [self checkDigitCode];
    }
}

- (IBAction)closeButtonClicked:(id)sender {
    [self processCloseDigitCodeView];
}


@end
