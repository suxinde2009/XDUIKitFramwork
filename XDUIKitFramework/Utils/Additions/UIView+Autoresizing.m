#import "UIView+Autoresizing.h"

@implementation UIView (Autoresizing)

- (void) addSubviewLeft:(UIView *)leftView middleView:(UIView *)middleView rightView:(UIView *)rightView lefWidth:(CGFloat)lefWidth rightWidth:(CGFloat)rightWidth margin:(CGRect)marginFrame {
    ;
}

- (void) addSubviewLeft:(UIView *)leftView middleView:(UIView *)middleView rightView:(UIView *)rightView lefWidth:(CGFloat)lefWidth rightWidth:(CGFloat)rightWidth {
    if(leftView) {
        leftView.frame = CGRectMake(0, 0, lefWidth, self.frame.size.height);
        leftView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:leftView];
    }
    if(middleView) {
        middleView.frame = CGRectMake(lefWidth, 0, self.frame.size.width - lefWidth - rightWidth, self.frame.size.height);
        middleView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:middleView];
    }
    if(rightView) {
        rightView.frame = CGRectMake(self.frame.size.width - rightWidth, 0, rightWidth, self.frame.size.height);
        rightView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin ;
        [self addSubview:rightView];
    }
}

- (void) addSubviewTop:(UIView *)topView middleView:(UIView *)middleView bottomView:(UIView *)bottomView topHeight:(CGFloat)topHeight bottomHeight:(CGFloat)bottomHeight {
    if(topView) {
        topView.frame = CGRectMake(0, 0, self.frame.size.width, topHeight);
        topView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:topView];
    }
    if(middleView) {
        middleView.frame = CGRectMake(0, topHeight, self.bounds.size.width, self.frame.size.height - topHeight - bottomHeight);
        middleView.autoresizingMask =UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth ;
        [self addSubview:middleView];
    }
    if(bottomView) {
        bottomView.frame = CGRectMake(0, self.frame.size.height - bottomHeight, self.frame.size.width, bottomHeight);
        bottomView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin ;
        [self addSubview:bottomView];
    }
}

//左上右下
- (void) addSubview:(UIView *)aView margin:(CGRect)marginFrame {
    if (!aView) return;
    aView.frame = CGRectMake(marginFrame.origin.x, marginFrame.origin.y, self.frame.size.width - marginFrame.origin.x - marginFrame.size.width, self.frame.size.height - marginFrame.origin.y - marginFrame.size.height);
    aView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self addSubview:aView];
}

- (void) addSubview:(UIView *)aView size:(CGSize)aSize {
    if (!aView) return;
    aView.center = [self centerPoint];
    aView.bounds = CGRectMake(0, 0, aSize.width, aSize.height);
    aView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:aView];
}

//左上右下
- (void) setSizeInView:(UIView *)aView margin:(CGRect)marginFrame {
    if (!aView) return;
    self.frame = CGRectMake(marginFrame.origin.x, marginFrame.origin.y, aView.frame.size.width - marginFrame.origin.x - marginFrame.size.width, aView.frame.size.height - marginFrame.origin.y - marginFrame.size.height);
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

- (void) setCenterInView:(UIView *)aView size:(CGSize)aSize {
    if (!aView) return;
    self.center = [aView centerPoint];
    self.bounds = CGRectMake(0, 0, aSize.width, aSize.height);
    self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleBottomMargin;
}

- (CGPoint) centerPoint {
    return CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
}

@end


